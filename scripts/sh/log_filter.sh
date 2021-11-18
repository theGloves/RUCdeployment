#!/usr/bin/env bash
set -e

pattern=$1

kubectl get pod -n chainbft -o name | xargs -n 1 kubectl logs -n chainbft --prefix=true | grep -E "$1"