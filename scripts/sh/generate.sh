#! /usr/bin/env bash
set -e

OUTPUTDIR=$WORKDIR/test
BINARY=./bin/chain_bft

# prepare
mkdir -p $OUTPUTDIR
rm -rf $OUTPUTDIR/*

# TODO cache

bash ./scripts/sh/gen_config.sh

# peers
PEERS=""
for (( i = 1; i <= $NODE_CNT; i++ )); do
  # volume="$OUTPUTDIR/cbft${i}:/chain_bft/.chain_bft"
  volume="--home $OUTPUTDIR/cbft${i}"
  NODEID=`$BINARY show-node-id $volume`
  # NODEID=`docker run -v $volume $IMAGE show-node-id`
  PEERS=$PEERS"${NODEID}@10.43.10."$((${i}+49))":26656,"
done

echo $PEERS
python scripts/py/generate_yaml.py $PEERS 

# deployment
bash scripts/sh/transport.sh