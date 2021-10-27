# !/usr/bin/env sh
set -e
pods=$(kubectl get pods -n tendermint -o name | grep node)

gres=""

function get_CPU_IDLE {
    gres=""
    for p in $pods; do
        idle=$(kubectl exec ${p} -n tendermint -- "vmstat | tail -n +3 | head -1 " | awk '{print $15}')
        gres=$gres$idle","
    done
}


while [ 1 ] ;do
    get_CPU_IDLE
    echo $gres
    sleep 5
done