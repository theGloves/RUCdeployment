# !/usr/bin/env sh
set -e
pods=$(kubectl get pods -n tendermint -o name | grep node)

for p in $pods; do
    idle=$(kubectl exec ${p} -n tendermint -- vmstat | tail -n +3 | head -1 | awk '{print $15}')
    echo $idle
done
