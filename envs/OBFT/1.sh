#!/usr/bin/env bash
set -e

export F=1
export PROPOSALTIMEOUT="575ms" # 5s
export SYNCTIMEOUT="20ms" #2.5s
export SLOTTIMEOUT="20ms" #2.5s
export SLOTTIMEOUT1=575
export TXS=5000
export NODE_CNT=$(($F*3+1))
export THRESHOLD=$(($F*2))
export TIMEOUTTHRESHOLD=$(($F*2))
export SEED=1000

export BYZANTINEPROBABILITY="0.0"

export TAG="OBFT"
export IMAGE=$(echo $(cat config.json | jq ".${TAG}.image")|sed 's/\"//g')
export TEMPLATE=$(echo $(cat config.json | jq ".${TAG}.template")|sed 's/\"//g')
