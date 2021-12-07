#!/usr/bin/env bash
set -e

source env.sh

# 清空rancher环境

SLOTTIMEOUT=5
FS='2 3'
TXS='1000 2000 3000 4000 5000'

for F in $FS; do
    for txs in $TXS; do
        make clean
        NODE=$(($F*3+1))
        THRESHOLD=$(($F*2))
        bash scripts/sh/generate.sh $NODE $THRESHOLD $txs $SLOTTIMEOUT
        # 部署
        make quick

        #自动设置proxy
        sleep $((($NODE+3)*$SLOTTIMEOUT))

        bash scripts/sh/log_filter.sh "\[json\]" > log/json/json_${NODE}_${txs}_${SLOTTIMEOUT}.txt
    done
done