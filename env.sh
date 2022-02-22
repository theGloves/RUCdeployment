#!/usr/bin/env bash
set -e

# workdir=$(echo $(cat config/config.json | jq ".${TAG}.depolymentpwd")|sed 's/\"//g')
export WORKDIR=$PWD
export PSSH=./scripts/sh/pssh
export PSCP=./scripts/sh/pscp