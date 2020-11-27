#!/bin/bash
# Create workspace, clone pose_listener and build it.

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

. $CURRENT_DIR/evaluation.config

trap "exit 1" INT

mkdir -p $CATKIN_WS_DIR/src

git clone $POSE_LISTENER_URL $CATKIN_WS_DIR/src/pose_listener

if command -v catkin &> /dev/null
then
  catkin init -w $CATKIN_WS_DIR
  catkin config -w $CATKIN_WS_DIR --cmake-args -DCMAKE_BUILD_TYPE=Release
  catkin build -w $CATKIN_WS_DIR
elif command -v catkin_make &> /dev/null
then
  catkin_make -C $CATKIN_WS_DIR
else
  echo "Unable to build pose_listener. Either catkin or catkin_make must be installed."
  exit 1
fi
