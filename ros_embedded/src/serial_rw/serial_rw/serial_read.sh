#!/bin/bash

if [ $# -ne 2 ]; then
    echo "ERROR: SERIAL READ INVOKED WITH ARGUMENT MISMATCH!!"
    exit 1
fi

serial=$1
br=$2

#screen -L $serial $br
stty -F $serial $br

#cat $serial

data=$(timeout 0.1 cat $serial)

if [ -n "$data" ]; then
	echo "$data"
fi
