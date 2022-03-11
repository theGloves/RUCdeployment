#!/usr/bin/env bash
set -ex

FS='3 4 7 8'

TIMES=10

PROTOCOL="cbft"

# 不同的节点规模
for F in $FS; do
    NODE=$(($F*3+1))
    # 重复实验次数
    for ((i=1; i<=$TIMES; i++))
    do
        mkdir -p result/$PROTOCOL/$NODE/$i/pod
        bash entry.sh ./envs/$PROTOCOL/$F.sh result/$PROTOCOL/$NODE/$i
        
        make clean

        sleep 30
    done
    
    echo "${F} done."
done