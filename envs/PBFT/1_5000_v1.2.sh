#!/usr/bin/env bash
set -e

export F=5
export SLOTTIMEOUT="15000ms"
export SLOTTIMEOUT1=4
export TXS=5000
export NODE_CNT=$(($F*3+1))
export SEED=1000
export VCINTERVAL="5s"

export PROPOSALTIMEOUT="300ms"
export SYNCTIMEOUT="200ms"
export THRESHOLD=$(($F*2))
export TIMEOUTTHRESHOLD=$(($F*2))

export TAG="PBFTVC"
export IMAGE=$(echo $(cat config.json | jq ".${TAG}.image")|sed 's/\"//g')
export TEMPLATE=$(echo $(cat config.json | jq ".${TAG}.template")|sed 's/\"//g')
