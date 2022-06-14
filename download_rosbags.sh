#!/bin/bash
# Download rosbags from Rosario Dataset official site. The ones that will be
# download are taken from evaluation.config.

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $CURRENT_DIR/evaluation.config
mkdir -p $DATASET_DIR
cd $DATASET_DIR

trap "exit 1" INT

echo "Downloading sequence01..."
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence01.bag.00
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence01.bag.01
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence01.bag.02
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/calibration01.yaml
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence01_gt.txt

echo "Downloading sequence02..."
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence02.bag.00
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence02.bag.01
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/calibration02.yaml
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence02_gt.txt

echo "Downloading sequence03..."
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence03.bag
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/calibration03.yaml
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence03_gt.txt

echo "Downloading sequence04..."
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence04.bag
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/calibration04.yaml
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence04_gt.txt

echo "Downloading sequence05..."
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence05.bag.00
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence05.bag.01
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/calibration05.yaml
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence05_gt.txt

echo "Downloading sequence06..."
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence06.bag.00
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence06.bag.01
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/calibration06.yaml
wget http://fs01.cifasis-conicet.gov.ar:90/~robot_desmalezador/robot/sequence06_gt.txt

echo "Joining sequences..."
cat sequence01.bag.* > sequence01.bag
cat sequence02.bag.* > sequence02.bag
cat sequence05.bag.* > sequence05.bag
cat sequence06.bag.* > sequence06.bag

for s in `seq 1 6`; do
  echo "Decompressing sequence0$s..."
  rosbag decompress sequence0$s.bag
done

echo "Computing checksums ..."
for s in ${SEQUENCES[@]};
do
  md5sum sequence0$s.orig.bag
done
