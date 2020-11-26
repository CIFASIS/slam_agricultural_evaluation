#!/bin/bash
# Run SLAM systems (using Docker containers). Configuration is taken from modules.config.
# Parameter:
#   -Path of Rosario Dataset containing rosbags (files must be named sequence0*.bag)

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ "$#" -ne 1 ]; then
  echo "Path of Rosario Dataset should be provided as (the only) argument" >&2
  exit 1
fi

DATASET_DIR=$1

. $CURRENT_DIR/modules.config

trap "exit 1" INT

for m in ${MODULES[@]};
do
  echo "Running $m ..."
  $CURRENT_DIR/$m/run_all_rosario_sequences.sh $DATASET_DIR
done
