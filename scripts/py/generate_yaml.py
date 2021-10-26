# -*-coding:utf-8 -*-
import sys
import math
from collections import OrderedDict
from json import loads

template_filename = "resources/k8s-template.yaml"  # 读取模板文件
filename = "test/deployment-k8s.yaml"  # 输出文件名


def getPeers(peers, prev):
    if prev < 0:
        return ""
    return peers[prev]


def genYaml(image, node_cnt, peers):
    template = ""
    with open(template_filename, "r") as f:
        template = f.read()

    with open(filename, "w") as output:
        for i in range(node_cnt):
            peers_str = getPeers(peers, i - 1)
            parameters = {
                "id": i,
                "node_name": "node{}".format(i),
                "image": image,
                "ip_addr": "10.43.100.{}".format(100 + i),
                "log": "tendermint.log",
                "peers": peers_str,
            }

            output.write(template.format(**parameters))
            output.write("\n")


if __name__ == "__main__":
    # python generate_yaml.py {image} {node_cnt} {[id@ip,]}
    argv = sys.argv[1:]
    image = argv[0]
    node_cnt = int(argv[1])
    peers = argv[2].split(",")
    genYaml(image, node_cnt, peers)
