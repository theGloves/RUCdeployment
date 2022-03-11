#! /usr/bin/env bash
set -e

TYPES="proposal"
FS="1 2 3 4 5 6 7 8"

OUTPUT="./log/obft_slot_res.txt"
echo "">$OUTPUT
for TYPE in $TYPES; do
    for F in $FS; do
        python scripts/py/log_parser.py ./log/CBFT/${TYPE}_${F}.txt >>$OUTPUT

    done
            echo -e "\n">>$OUTPUT

done
cat $OUTPUT
# python scripts/py/log_parser.py ./log/gossip/proposal_8.txt 