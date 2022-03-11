#!/usr/bin/env bash
set -ex

FS="1 2 3 4 5 6 7 8"

for F in $FS; do
    bash entry.sh ./envs/CBFT_gossip/${F}.sh
    # bash entry.sh ./envs/CBFT/template.sh

    # sleep initialSleepTime + slot * 20
    sleep 75

    bash scripts/sh/log_filter.sh "set proposal success" > log/CBFT/proposal_${F}.txt
    bash scripts/sh/log_filter.sh "added vote" > log/CBFT/vote_${F}.txt

    make clean
    echo "$F done."
done