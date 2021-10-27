# !/usr/bin/env sh
set -e
pods=$(kubectl get pods -n tendermint -o name | grep node0)

gres=""

function get_CPU_IDLE {
    for p in $pods; do
        idle=`kubectl exec ${p} -n tendermint -- vmstat 1 6 | tail -n +4 | awk '{sum+=$15} END {print sum/NR'} `
        gres=$idle
    done
}


while [ 1 ] ;do
    get_CPU_IDLE
    echo $gres
    # sleep 5
done