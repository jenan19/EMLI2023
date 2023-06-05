#!/bin/bash
line=$(head -n 1 /var/www/html/water_alarms/log1.txt)
echo ${line:0-1}

