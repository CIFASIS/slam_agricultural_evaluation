#!/bin/bash
# Build Docker images. Configuration is taken from evaluation.config.

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $CURRENT_DIR/evaluation.config

trap "exit 1" INT

for m in ${MODULES[@]};
do
  echo "Building Docker image: $m ..."
  $CURRENT_DIR/$m/run.sh -b
done
