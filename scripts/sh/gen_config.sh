#!/usr/bin/env bash
set -e

source env.sh

OUTPUTDIR=$WORKDIR/test
BINARY=./bin/chain_bft

for (( i = 1; i <= $NODE_CNT; i++ )); do
  mkdir -p $OUTPUTDIR/cbft${i}
  volume="--home $OUTPUTDIR/cbft${i}"
  # volume="$OUTPUTDIR/cbft${i}:/chain_bft/.chain_bft"
  $BINARY gen-node-key $volume
  $BINARY gen-validator --idx $i --seed $SEED --thres $THRESHOLD $volume
  # docker run -v $volume $IMAGE gen-node-key
  # docker run -v $volume $IMAGE gen-validator --idx $i --seed $SEED --thres $THRESHODL
  chmod -R 777 $OUTPUTDIR/cbft${i}
  chmod 777 $OUTPUTDIR/cbft${i}/*
done

# 生成创世文件
# volume="$OUTPUTDIR/template/:/chain_bft/.chain_bft"  
volume="--home $OUTPUTDIR/template"
$BINARY  gen-genesis-block --seed $SEED --thres $THRESHOLD --cluster-count $NODE_CNT $volume
# docker run -v $volume $IMAGE gen-genesis-block --seed $SEED --thres $THRESHODL --cluster-count $NODE_CNT
chmod 777 $OUTPUTDIR/template/config/genesis.json
for (( i = 1; i <= $NODE_CNT; i++ )); do
  cp $OUTPUTDIR/template/config/genesis.json $OUTPUTDIR/cbft${i}/config/genesis.json
done