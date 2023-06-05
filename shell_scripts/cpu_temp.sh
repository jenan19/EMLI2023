#!/bin/bash
CPU_TEMPM=$(cat /sys/class/thermal/thermal_zone*/temp)
CPU_TEMP=$(expr $CPU_TEMPM / 1000)
echo "$CPU_TEMP"

