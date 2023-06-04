#!/bin/bash
file="/var/www/html/log.txt"

# check for empty argv
if [ $# -ne 2 ]; then
    echo "ERROR: WRITE INVOKED WITH ARGUMENT MISMATCH!!"
    exit 1
fi
# set output to argv

file="$2"
DATA="$1"
#echo "$DATA"
#printf  "$DATA\n" >> "$serial"

sed  "1 i $DATA" "$file" > changed.txt && mv changed.txt "$file" 
