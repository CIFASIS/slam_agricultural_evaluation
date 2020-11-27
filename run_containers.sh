#!/bin/bash
# Run SLAM systems (using Docker containers). Configuration is taken from evaluation.config.

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $CURRENT_DIR/evaluation.config

trap "exit 1" INT

for m in ${MODULES[@]};
do
  echo "Running $m ..."
  $CURRENT_DIR/$m/run_all_rosario_sequences.sh $DATASET_DIR
done
