#!/usr/bin/env bash
set -e

FS="1 2 3 4 5 6 7 8"

for F in $FS; do
    bash entry.sh ./envs/CBFT/${F}.sh

    # sleep initialSleepTime + slot * 20
    sleep 60

    bash scripts/sh/log_filter.sh "set proposal success" > log/gossip/proposal_${F}.txt
    bash scripts/sh/log_filter.sh "added vote" > log/gossip/vote_${F}.txt
done