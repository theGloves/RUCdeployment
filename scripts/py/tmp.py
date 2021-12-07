# -*-coding:utf-8 -*-

import random

availablePeers = {}
neighbors_num = 4


def generate_gossip(peers, neighbors_num):
    n = len(peers)

    res = [[peers[i]] for i in range(n)]

    lst = random.sample(range(0, n), n)
    print(lst)
    # 将一个人设置为其他人的邻居
    for i in lst:
        p = peers[i]
        availableNum = neighbors_num
        for t in range(n):
            if p in res[t] or len(res[t]) > neighbors_num:
                continue
            res[t].append(p)
            availableNum -= 1
            if availableNum < 1:
                break

    return [t[1:] for t in res]


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
        ite -= 1

    return ",".join(result[1:])

def getPeers(peers, cur, neighbors_num):
    if cur < 0:
        return ""
    l = cur - neighbors_num
    r = cur
    if cur % 2==1:
        l = cur + 1
        r = cur + 1+neighbors_num
    if l < 0 or r < 0:
        l += len(peers)
        r += len(peers)
    tmp = []
    for i in range(l, r, 1):
        tmp.append(peers[i % len(peers)])
    return ",".join(tmp)

if __name__ == "__main__":
    p = ["1", "2", "3", "4", "5", "6"]
    res = generate_gossip(p, 3)

    
    for i in range(len(p)):
        print(p[i], getPeers(p,i, 3))