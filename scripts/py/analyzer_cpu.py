# -*-coding:utf-8 -*-

import sys
import numpy as np


def cpu_idle(filename):
    data = []
    with open(filename, "r") as f:
        line = f.readline()
        while line:
            tmp = list(
                map(lambda x: int(x), filter(lambda x: x.isdigit(), line.split(",")))
            )
            data += tmp
            line = f.readline()
    return data


if __name__ == "__main__":
    filename = sys.argv[1]
    idle = np.array(cpu_idle(filename))
    print(np.percentile(idle, 99))
