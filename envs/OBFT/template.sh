#!/usr/bin/env bash
set -e

export F=1
export SLOTTIMEOUT="1200ms" #2.5s
export SLOTTIMEOUT1=4
export TXS=5000
export NODE_CNT=$(($F*3+1))
export SEED=1000

# unused
export THRESHOLD=$(($F*2))
export TIMEOUTTHRESHOLD=$(($F*2))
export SYNCTIMEOUT="20ms" #2.5s
export PROPOSALTIMEOUT="260ms" # 5s
export BYZANTINEPROBABILITY="0.0"

export TAG="OBFT"
export IMAGE=$(echo $(cat config.json | jq ".${TAG}.image")|sed 's/\"//g')
export TEMPLATE=$(echo $(cat config.json | jq ".${TAG}.template")|sed 's/\"//g')
