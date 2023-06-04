#!/bin/bash
water=$(ros2 topic echo "$1"/water_alarm --once | awk '/data:/{ gsub("\047", ""); print $2}')
pump=$(ros2 topic echo "$1"/pump_alarm --once | awk '/data:/{ gsub("\047", ""); print $2}')
moist=$(ros2 topic echo "$1"/moisture --once | awk '/data:/{ gsub("\047", ""); print $2}')

if [ $pump = 0 ]; then 
	if [ $water = 0 ]; then
		if [ $moist -lt 50 ]; then
			value="green"
		else
			value="yellow"
		fi
	else
		value="red"
	fi
else
	value="red"
fi

echo $value
