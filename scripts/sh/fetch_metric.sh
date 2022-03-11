#!/usr/bin/env bash
set -e

POD=$1
OUTPUT=$2

kubectl exec -n cbft $1 -- curl "127.0.0.1:26657/performance?start=1&end=100"  | jq .result > $2