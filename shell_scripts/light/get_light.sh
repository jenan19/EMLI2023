#!/bin/bash
source /home/pi/ros_embedded/install/setup.bash
value=$(ros2 topic echo "$1"/light --once | awk '/data:/{ gsub("\047", ""); print $2}')
echo $value

