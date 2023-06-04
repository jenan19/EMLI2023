#!/bin/bash
x=1
while [ $x -le 60 ]
do
	value=$(/home/pi/shell_scripts/pump/save_pump.sh plant1)
	echo $value >> pump_data.txt
	x=$(( $x + 1 ))
done
