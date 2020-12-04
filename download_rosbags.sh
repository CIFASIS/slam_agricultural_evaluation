#!/bin/bash
# Download rosbags from Rosario Dataset official site. The ones that will be
# download are taken from evaluation.config.

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $CURRENT_DIR/evaluation.config
mkdir -p $DATASET_DIR
cd $DATASET_DIR

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
