#! /usr/bin/env bash
set -e

source env.sh

# deployment
ssh -i ~/.ssh/ruc_500_new centos@10.77.70.82 "sudo rm -rf /home/centos/share/tendermint"
scp -r -i ~/.ssh/ruc_500_new ./test centos@10.77.70.82:/home/centos/share/tendermint
ssh -i ~/.ssh/ruc_500_new centos@10.77.70.82 "sudo chmod 777 /home/centos/share/tendermint/node*/config/*"