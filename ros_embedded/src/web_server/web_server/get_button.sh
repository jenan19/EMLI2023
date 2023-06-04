#!/bin/bash

if [ $# -ne 2 ]; then
	echo "error argument mismatch"
	exit 1
fi


ip="$1"
btn="$2"
response=$(curl -s "$ip/button/$btn/count")

if [ $? -eq 0 ]; then
    echo "$response"
else
    echo "Failed to retrieve text content from $ip."
fi

