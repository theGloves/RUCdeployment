# -*-coding:utf-8 -*-
import sys
import os
import random
from collections import OrderedDict
from json import loads

# template_filename = "resources/k8s-template.yaml"  # 读取模板文件
template_filename = os.getenv("TEMPLATE")  # 读取模板文件
filename = "test/deployment-k8s.yaml"  # 输出文件名

availablePeers = {}
neighbors_num = 16

# byzantine_nodes = [3, 5, 8, 12, 15]
byzantine_nodes = [ ]


def getPeers(peers, cur, neighbors_num):
    # return ",".join(peers)
    if cur < 0:
        return ""
    l = cur - neighbors_num
    r = cur
    if cur % 2 == 1:
        l = cur + 1
        r = cur + 1+neighbors_num
    if l < 0 or r < 0:
        l += len(peers)
        r += len(peers)
    tmp = []
    for i in range(l, r, 1):
        tmp.append(peers[i % len(peers)])
    return ",".join(tmp)


def getPeers_gossip(peers, cur):
    selfP = peers[cur]
    ite = neighbors_num
    result = [selfP]
    while ite > 0:
        idx = random.randint(0, len(peers) - 1)  # [0, len(peers) )
        p = peers[idx]
        if p in result or availablePeers[p] == 0:
            continue
        availablePeers[p] -= 1
        result.append(p)

    return ",".join(result[1:])


def genYaml(peers):
    node_cnt = int(os.getenv("NODE_CNT"))
    for peer in peers:
        availablePeers[peer] = neighbors_num

    template = ""
    with open(template_filename, "r") as f:
        template = f.read()

    neighbors_file = open("./test/neighbors.txt", "w")
    with open(filename, "w") as output:
        for i in range(node_cnt):
            peers_str = getPeers(peers, i, neighbors_num)
            neighbors_file.write("{}#{}".format(peers[i], peers_str))
            neighbors_file.write("\n")
            strategy = "normal"
            if i in byzantine_nodes:
                strategy = "silence"
            parameters = {
                "id": i + 1,
                "node_name": "cbft{}".format(i + 1),
                "image": os.getenv("IMAGE"),
                "peers": peers_str,
                "ip_addr": "10.43.10.{}".format(100 + i),
                "tx_num": int(os.getenv("TXS")),
                "slot_timeout": os.getenv("SLOTTIMEOUT"),
                "vc_interval": os.getenv("VCINTERVAL"),
                "proposal_timeout": os.getenv("PROPOSALTIMEOUT"),
                "sync_timeout": os.getenv("SYNCTIMEOUT"),
                "timeout_threshold": int(os.getenv("TIMEOUTTHRESHOLD")),
                "threshold": int(os.getenv("THRESHOLD")),
                "byzantine_strategy": strategy,
            }

            output.write(template.format(**parameters))
            output.write("\n")


if __name__ == "__main__":
    # python generate_yaml.py {[id@ip,]}
    argv = sys.argv[1:]
    peers = argv[0].split(",")[:-1]
    genYaml(peers)
