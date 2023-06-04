#!/bin/bash
x=1
while [ $x -le 60 ]
do
	value=$(/home/pi/shell_scripts/light/get_light.sh plant1)
	echo $value >> light_data.txt
	x=$(( $x + 1 ))
done
