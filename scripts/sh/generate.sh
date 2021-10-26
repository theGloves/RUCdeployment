#! /usr/bin/env bash
set -e

source env.sh

NODE_CNT=$1
OUTPUTDIR=$WORKDIR/test

# prepare
mkdir -p $OUTPUTDIR
rm -rf $OUTPUTDIR/*

# TODO cache

bash ./scripts/sh/gen_config.sh $NODE_CNT

# peers
PEERS=""
for (( i = 1; i <= $NODE_CNT; i++ )); do
  volume="--home ./test/node"$(($i-1))
  NODEID=`./bin/tendermint show-node-id $volume`
  PEERS=$PEERS"${NODEID}@10.43.100."$((${i}+99))":26656,"
done

python scripts/py/generate_yaml.py $IMAGE $NODE_CNT $PEERS

# deployment
ssh -i ~/.ssh/ruc_500_new centos@10.77.70.135 "sudo rm -rf /home/centos/share/tendermint; mkdir -p /home/centos/share/tendermint"
scp -r ./test/* centos@10.77.70.135:/home/centos/share/tendermint
ssh -i ~/.ssh/ruc_500_new centos@10.77.70.135 "sudo chmod 777 /home/centos/share/tendermint/node*/config/*"
