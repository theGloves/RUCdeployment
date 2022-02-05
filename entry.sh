#!/usr/bin/env bash
set -e

source env.sh

# 清空rancher环境
# make clean

bash scripts/sh/generate.sh
exit 0
# 部署
make quick

if [ $1 ];then
#自动设置proxy
sleep $((3*$SLOTTIMEOUT1))
kubectl port-forward -n chainbft service/cbft4 ${PROXYPORT}:${PROXYPORT}
fi