#!/bin/bash

DATE_LOG=$(date '+%Y%m%d_%H%M%S')
./build_images.sh 2>&1 | tee build_images_log_$DATE_LOG.txt
