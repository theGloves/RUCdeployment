#!/usr/bin/env bash
set -e

TAG="dev"

# workdir=$(echo $(cat config/config.json | jq ".${TAG}.depolymentpwd")|sed 's/\"//g')
WORKDIR=$PWD
IMAGE=$(echo $(cat config.json | jq ".${TAG}.image")|sed 's/\"//g')