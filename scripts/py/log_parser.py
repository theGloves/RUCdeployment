# -*-coding:utf-8 -*-
import re
import sys
import numpy as np


def parser_gossip_round(txt):
    pattern = re.compile("round=([-]*\d+)")
    res = pattern.search(txt)
    if res is None:
        return None
    t = int(res.group(1))
    if t <= 0:
        return 0
    return t

def parser_gossip_time(txt):
    pattern = re.compile("slottime=([-]*\d+)")
    res = pattern.search(txt)
    if res is None:
        return None
    t = int(res.group(1))
    if t <= 0:
        return 0
    return t


if __name__ == "__main__":
    input = sys.argv[1]
    times=[]
    
    rounds=[]
    with open(input, "r") as f:
        line = f.readline()
        
        while line:
            t = parser_gossip_time(line)
            r = parser_gossip_round(line)
            if t is not None and t>0:
                times.append(t)
            if r is not None:
                rounds.append(r)
            line = f.readline()
    
    # print("max,tp75,tp25,avg,mid")
    print("{},{},{},{},{}".format(np.percentile(times,99),np.percentile(times,75),np.percentile(times,25),np.mean(times),np.median(times)))
    # print("{},{},{},{},{}".format(np.percentile(rounds,99),np.percentile(rounds,75),np.percentile(rounds,25),np.mean(rounds),np.median(rounds)))
