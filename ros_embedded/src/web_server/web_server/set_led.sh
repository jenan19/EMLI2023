#!/bin/bash

if [ $# -ne 3 ]; then
	echo "argument mismatch"
  	exit 1
fi

ip=$1
led=$2
state=$3


curl "$ip/led/$led/$state"
