#!/usr/bin/env bash

if [[ $# -eq 0 ]] ; then
    echo "Run this with: rovioli_create_map.sh [Input ROS bag] [Sensor configuration file] [Output folder for map]"
    exit 1
fi

ROSBAG=$1
ROVIO_CONFIG_DIR=$2
LOCALIZATION_MAP_OUTPUT=$3
# ROVIO_CONFIG_DIR=/datasets/euroc/config
REST=$@

# Command updated, REF: https://github.com/ethz-asl/maplab/issues/315

rosrun rovioli rovioli \
  --alsologtostderr=1 \
  --v=2 \
  --sensor_calibration_file=$NCAMERA_CALIBRATION \
  --datasource_type="rosbag" \
  --save_map_folder="$LOCALIZATION_MAP_OUTPUT" \
  --optimize_map_to_localization_map=false \
  --map_builder_save_image_as_resources=false \
  --datasource_rosbag=$ROSBAG $REST
