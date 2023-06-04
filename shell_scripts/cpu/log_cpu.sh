#!/bin/bash
date=$(date "+%H:%M:%S_%d-%m-%y.txt")
touch "/var/www/html/Server_health/data/cpu/${date}"
tail -10 /home/pi/shell_scripts/cpu/cpu_temp.txt >> "/var/www/html/Server_health/data/cpu/${date}"

