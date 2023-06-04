#!/bin/bash
source /home/pi/ros_embedded/install/setup.bash
error="Could not determine the type for the passed topic"

value=$(ros2 topic echo "$1"/light --once | awk '/data:/{ gsub("\047", ""); print $2}')

if [ $value = $error ]; then
        value=0
fi
echo $value


