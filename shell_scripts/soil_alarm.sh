#!/bin/bash
line=$(head -n 1 /var/www/html/Soil_moisture/log.txt)
echo ${line:0-2}

