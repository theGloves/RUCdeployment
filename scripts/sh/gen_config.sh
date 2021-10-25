#!/usr/bin/env bash
set -e

source env.sh

NODE_CNT=$1
THRESHODL=$2
SEED=$3
OUTPUTDIR=$WORKDIR/test

for (( i = 1; i <= $NODE_CNT; i++ )); do
  mkdir -p $OUTPUTDIR/cbft${i}
  volume="$OUTPUTDIR/cbft${i}:/chain_bft/.chain_bft"
  
  docker run -v $volume $IMAGE gen-genesis-block --seed $SEED --thres $THRESHODL --cluster-count $NODE_CNT
  docker run -v $volume $IMAGE gen-node-key
  docker run -v $volume $IMAGE gen-validator --idx $i --seed $SEED --thres $THRESHODL
  chmod -R 777 $OUTPUTDIR/cbft${i}
  chmod 777 $OUTPUTDIR/cbft${i}/*
done
