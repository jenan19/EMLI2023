#!/bin/bash
source /home/pi/ros_embedded/install/setup.bash
value=$(ros2 topic echo "$1"/moisture --once | awk '/data:/{ gsub("\047", ""); print $2}')
error="Could not determine the type for the passed topic"
if [ "$value" = "$error" ]; then
        value=0
fi
echo $value

