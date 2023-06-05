#!/bin/bash
list=$(echo $(tail -n 60 "/home/pi/shell_scripts/light/light_data.txt") | tr ' ' '\n' | tac | xargs)
echo "" > '/home/pi/shell_scripts/light/light_data_latest.txt'
IFS=' ' read -r -a array <<< "$list"

for element in "${array[@]}"
do
    echo $element >> '/home/pi/shell_scripts/light/light_data_latest.txt'
done


/home/pi/shell_scripts/light/plot.sh
