#!/usr/bin/env bash
set -e

source $1
source env.sh

# 清空rancher环境
make clean

bash scripts/sh/generate.sh
# 部署
make quick

if [ $2 ];then
#自动设置proxy
sleep $((3*$SLOTTIMEOUT1))
export PROXYPORT=26657
kubectl port-forward -n chainbft service/cbft2 ${PROXYPORT}:${PROXYPORT}
fi