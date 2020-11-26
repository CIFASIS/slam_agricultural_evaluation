#!/bin/bash
# Build Docker images. Configuration is taken from modules.config.

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $CURRENT_DIR/modules.config

trap "exit 1" INT

for m in ${MODULES[@]};
do
  echo "Building $m ..."
  $CURRENT_DIR/$m/run.sh -b
done