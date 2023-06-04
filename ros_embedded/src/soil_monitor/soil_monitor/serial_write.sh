#!/bin/bash
serial="/dev/ttyACM0"

# cHeck for empty argv
if [ $# -ne 2 ]; then
    echo "ERROR: SERIAL READ INVOKED WITH ARGUMENT MISMATCH!!"
    exit 1
fi
# set output to argv

serial="$1"
DATA="$2"
echo -e "$DATA" > "$serial"
#echo "Data sent to $serial: $DATA"

