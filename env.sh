#!/usr/bin/env bash
set -e

TAG="dev"

F=1
SLOTTIMEOUT=5
TXS=1000
NODE_CNT=$(($F*3+1))
THRESHOLD=$(($F*2))
SEED=$RANDOM

# workdir=$(echo $(cat config/config.json | jq ".${TAG}.depolymentpwd")|sed 's/\"//g')
WORKDIR=$PWD
IMAGE=$(echo $(cat config.json | jq ".${TAG}.image")|sed 's/\"//g')
PSSH=./scripts/sh/pssh
PSCP=./scripts/sh/pscp
