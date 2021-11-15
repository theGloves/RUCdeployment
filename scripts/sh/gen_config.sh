#!/usr/bin/env bash
set -e

source env.sh

NODE_CNT=$1

OUTPUTDIR=$WORKDIR/test

./bin/tendermint_v03411 testnet --v $NODE_CNT --o ./test
chmod -R 777 test/node*
