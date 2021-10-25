#! /usr/bin/env bash
set -e

source env.sh

NODE_CNT=$1
THRESHODL=$2
OUTPUTDIR=$WORKDIR/test

# prepare
mkdir -p $OUTPUTDIR
rm -rf $OUTPUTDIR/*

# TODO cache

bash ./scripts/sh/gen_config.sh $NODE_CNT $THRESHODL $RANDOM

# peers
PEERS=""
for (( i = 1; i <= $NODE_CNT; i++ )); do
  volume="$OUTPUTDIR/cbft${i}:/chain_bft/.chain_bft"
  NODEID=`docker run -v $volume $IMAGE show-node-id`
  PEERS=$PEERS"${NODEID}@10.43.10."$((${i}+99))":26656,"
done

python scripts/py/generate_yaml.py $IMAGE $NODE_CNT $PEERS

# deployment
scp -r ./test centos@10.77.70.135:/home/centos/share