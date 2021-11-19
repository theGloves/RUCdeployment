#!/usr/bin/env bash
set -e

source env.sh

# 清空rancher环境
make clean

bash scripts/sh/generate.sh 8 3

# 部署
make quick

#自动设置proxy
sleep 5
kubectl port-forward -n chainbft service/cbft1 26657:26657
