#!/bin/bash
value=$(ros2 topic echo "$1"/pump_alarm --once | awk '/data:/{ gsub("\047", ""); print $2}')

echo $value
