#!/usr/bin/env bash
set -e

#PBFT-v1.3 sleep模拟view change

export F=7
export SLOTTIMEOUT="15000ms"
export SLOTTIMEOUT1=4
export TXS=5000
export NODE_CNT=$(($F*3+1))
export SEED=1000
export VCINTERVAL="3s"
export BYZANTINEPROBABILITY="0.0"

export PROPOSALTIMEOUT="300ms"
export SYNCTIMEOUT="200ms"
export THRESHOLD=$(($F*2))
export TIMEOUTTHRESHOLD=$(($F*2))

export TAG="PBFTSIM"
export IMAGE=$(echo $(cat config.json | jq ".${TAG}.image")|sed 's/\"//g')
export TEMPLATE=$(echo $(cat config.json | jq ".${TAG}.template")|sed 's/\"//g')
