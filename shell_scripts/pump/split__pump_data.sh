#!/bin/bash

filename="/var/www/html/water_alarms/log.txt"

line1=$(head -n 1 "$filename")
second_part=${line1#*,}  
time=${second_part%,*}
date=${time% *}
monthday=${date#*-}
firstday=${monthday#*-}
firstday="$(($firstday))"
line=""
day=$firstday
x=2

newfile="/var/www/html/pump_activations/data/${date}.txt"

#echo $date
#echo "${date}.txt"

while [ $day -eq $firstday ]
do
  line=$(head -n $x "$filename"| tail -1)
  second_part=${line#*,}  
  
  time=${second_part%,*}
  date=${time% *}
  monthday=${date#*-}
  day=${monthday#*-}
  day="$(($day))"
  x=$(( $x + 1 ))
  #echo $date
done

#echo $x
#echo "${newfile}"
log=$(head -n $x "$filename")


echo "${log}" > "${newfile}"
	
