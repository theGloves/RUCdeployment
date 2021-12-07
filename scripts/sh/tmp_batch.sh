#!/usr/bin/env bash
set -e

FS='2 3 4 5 6'

for F in $FS; do
    NODE=$(($F*3+1))
    FILES=`find log/network -name "ps_${NODE}_*.txt" | xargs`
    FILES=${FILES// /,}

    python scripts/py/log_extract.py $FILES log/network/analysis/ps_${NODE}.csv
    FILES=`find log/network -name "gossip_${NODE}_*.txt" | xargs`
    FILES=${FILES// /,}
    python scripts/py/log_extract.py $FILES log/network/analysis/gossip_${NODE}.csv
done