#!/usr/bin/env bash
set -e

source $1
source env.sh

# 清空rancher环境
make clean

bash scripts/sh/generate.sh
# 部署
make quick

sleep 5
export PROXYPORT=26657
kubectl port-forward -n cbft service/cbft2 ${PROXYPORT}:${PROXYPORT}

if [ $2 ];then
#自动保存结果到$2指定的目录
# sleep $(((${SLOTTIMEOUT1}*110/1000)+30))
sleep 120
# export PROXYPORT=26657
# kubectl port-forward -n cbft service/cbft2 ${PROXYPORT}:${PROXYPORT}
kubectl get pod -n cbft -o name | xargs -n 1 -I {} bash ./scripts/sh/fetch_metric.sh {} $2/{}.json
fi