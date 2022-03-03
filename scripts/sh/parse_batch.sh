#! /usr/bin/env bash
set -e

TYPES="proposal vote"
FS="1 2 3 4 5 6 7 8"

OUTPUT="./log/slot_res.txt"
echo "">$OUTPUT
for TYPE in $TYPES; do
    for F in $FS; do
        python scripts/py/log_parser.py ./log/gossip/${TYPE}_${F}.txt >>$OUTPUT

    done
            echo -e "\n">>$OUTPUT

done

# python scripts/py/log_parser.py ./log/gossip/proposal_8.txt 