#!/bin/bash
list=$(echo $(tail -n 60 "/home/pi/shell_scripts/cpu/cpu_temp.txt") | tr ' ' '\n' | tac | xargs)
echo "" > '/home/pi/shell_scripts/cpu/cpu_temp_latest.txt'
IFS=' ' read -r -a array <<< "$list"

for element in "${array[@]}"
do
    echo $element >> '/home/pi/shell_scripts/cpu/cpu_temp_latest.txt'
done

/home/pi/shell_scripts/cpu/plot.sh
