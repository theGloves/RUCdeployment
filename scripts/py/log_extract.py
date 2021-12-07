# -*-coding:utf-8 -*-
import re
import sys

user_patterns = [
    ("slot", "[^ ]+"),
    ("nodeid", "[^ ]+"),
    ("round", "[^ ]+"),
    ("txs", "[^ ]+"),
    ("MBsize", "[^ ]+"),
    ("networktime\(ms\)", "[^ ]+"),
    ("totaltime\(ms\)", "[^ ]+"),
]


def log_extract(filename):
    s = ""
    for p in user_patterns:
        s += ".+{}=({})".format(p[0], p[1])
    pattern = re.compile(s, flags=0)
    result = []

    with open(filename, "r") as f:
        line = f.readline()
        while line:
            try:
                line = line.replace("\n", "")
                res = pattern.match(line)
                result.append(",".join(res.groups()) + "\n")
            except print(0):
                pass
            finally:
                line = f.readline()
    return result


if __name__ == "__main__":
    logfiles = sys.argv[1].split(",")
    res = []
    for logf in logfiles:
        res += log_extract(logf)


    head = ""
    for p in user_patterns:
        head += "{},".format(p[0])
    head+="\n"
    
    output = sys.argv[2]
    with open(output, "w") as f:
        f.writelines([head]+res)
