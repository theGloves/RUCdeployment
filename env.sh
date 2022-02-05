#!/usr/bin/env bash
set -e

export TAG="pbft"

export F=1
export PROPOSALTIMEOUT="300ms"
export SYNCTIMEOUT="200ms"
export SLOTTIMEOUT="200ms"
export SLOTTIMEOUT1=4
export TXS=1000
export NODE_CNT=$(($F*3+1))
export THRESHOLD=$(($F*2))
export TIMEOUTTHRESHOLD=$(($F*2))
# SEED=1000
export SEED=$RANDOM
export PROXYPORT=26657

# workdir=$(echo $(cat config/config.json | jq ".${TAG}.depolymentpwd")|sed 's/\"//g')
export WORKDIR=$PWD
export IMAGE=$(echo $(cat config.json | jq ".${TAG}.image")|sed 's/\"//g')
export PSSH=./scripts/sh/pssh
export PSCP=./scripts/sh/pscp