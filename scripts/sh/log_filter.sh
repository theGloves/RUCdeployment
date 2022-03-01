#!/usr/bin/env bash
set -e

pattern=$1

kubectl get pod -n cbft -o name | xargs -n 1 kubectl logs -n cbft --prefix=true | grep -E "$1"