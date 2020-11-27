#!/bin/bash
# Download rosbags from Rosario Dataset official site. The ones that will be
# download are taken from evaluation.config.
# Parameter:
#   -Path where rosbags will be (it is recommended to download them in local,
#   and preferably fast, storage). If it does not exist, it will be created.

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ "$#" -ne 1 ]; then
  echo "Path of Rosario Dataset should be provided as (the only) argument" >&2
  exit 1
fi

DATASET_DIR=$1
mkdir -p $DATASET_DIR
cd $DATASET_DIR

. $CURRENT_DIR/evaluation.config

trap "exit 1" INT

for s in ${SEQUENCES[@]};
do
  echo "Downloading sequence0$s ..."
  wget http://fs01.cifasis-conicet.gov.ar:90/~comelli/permanent/sequence0$s.bag
  wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/calibration0$s.yaml
  wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence0${s}_gt.txt
done

echo "Computing checksums ..."
for s in ${SEQUENCES[@]};
do
  md5sum sequence0$s.bag
done
