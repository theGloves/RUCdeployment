# -*-coding:utf-8 -*-

# 分析batch的实验结果，传入一次batch的指标数据
# 数据文件目录组织形式
# batch_test/
#     [node]/   -  一个节点规模为一组，一组实验一个单独的文件夹
#         [times]/      -   第i次重复实验，一次实验单独的一个文件夹
#             pod/[pods.json] -   一次实验每个节点有一个指标文件，要么为json，要么为null


import re
from statistics import mean
import sys
import json
import os
import numpy as np

# ----- helper function ---------
# 返回一个路径下面所有的文件夹(绝对路径)
def getAllDir(path):
    res = []
    for f in os.listdir(path):
        fPath = os.path.join(path, f)
        if os.path.isdir(fPath) == False:
            continue #不是node类型的文件夹
        res.append(fPath)
    return res

def getAllJsonFiles(path):
    res = []
    for f in os.listdir(path):
        fPath = os.path.join(path, f)
        if f.find("json") == -1:
            continue #不是json类型的文件夹
        res.append(fPath)
    return res
# -------------------------------

# 从一组json文件中取出想要的数据，然后返回TPS和latency
def getExpData(jsonFiles):
    tps = []
    latency = []
    for fpath in jsonFiles:
        try:
            f = open(fpath, "r")
            data = json.load(f)
            tps.append(data['tps'])
            latency.append(data["ResultLatency"]["mean_tx_latency"])
        except Exception as e:
            pass
    return tps, latency

def analyze_exp_data(path):
    res = []
    nodes = getAllDir(path)
    for nodePath in nodes:
        node = os.path.basename(nodePath)
        timesTPS = []
        timesLatency = []
        times = [os.path.join(p, "pod") for p in getAllDir(nodePath)]
        for timePath in times:
            jsons = getAllJsonFiles(timePath)
            # 一次实验中取所有节点结果的最大值
            tps, latency = getExpData(jsons)
            if len(tps) == 0 or len(latency) == 0 :
                continue
            timesTPS.append(max(tps))
            timesLatency.append(mean(latency))
        # 一组实验中取所有重重实验结果的某个值
        res.append((node, np.mean(timesTPS), np.mean(timesLatency)))
    res = sorted(res, key=lambda x: int(x[0]),reverse=False)
    for r in res:
        print("{},{},{}".format(r[0],r[1],r[2]))
            
            
if __name__ == "__main__":
    dataPath  = sys.argv[1]
    analyze_exp_data(dataPath)
