# -*-coding:utf-8 -*-
import sys
import random
from collections import OrderedDict
from json import loads

template_filename = "resources/k8s-template.yaml"  # 读取模板文件
filename = "test/deployment-k8s.yaml"  # 输出文件名

availablePeers = {}
neighbors_num = 4


def getPeers(peers, cur, neighbors_num):
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


def genYaml(image, node_cnt, tx_num, slot_timeout, threshold, peers):
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
            parameters = {
                "id": i + 1,
                "node_name": "cbft{}".format(i + 1),
                "image": image,
                "peers": peers_str,
                "ip_addr": "10.43.10.{}".format(100 + i),
                "tx_num": tx_num,
                "slot_timeout": slot_timeout,
                "threshold": threshold,
            }

            output.write(template.format(**parameters))
            output.write("\n")


if __name__ == "__main__":
    # python generate_yaml.py {image} {node_cnt} {[id@ip,]}
    argv = sys.argv[1:]
    image = argv[0]
    node_cnt = int(argv[1])
    tx_num = int(argv[2])
    slot_timeout = int(argv[3])
    threshold = int(argv[4])
    peers = argv[5].split(",")[:-1]
    genYaml(image, node_cnt, tx_num, slot_timeout, threshold, peers)
