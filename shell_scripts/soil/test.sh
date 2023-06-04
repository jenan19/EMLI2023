#!/bin/bash
x=1
while [ $x -le 60 ]
do
	value=$(/home/pi/shell_scripts/soil/get_soils.sh plant1)
	echo $value >> soil_data.txt
	x=$(( $x + 1 ))
done
