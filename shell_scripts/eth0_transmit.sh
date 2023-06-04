#!/bin/bash
memUsage=$(cat /proc/net/dev | awk '/eth0:/{print $10}')
toMB=$(expr $memUsage / 1000000)
echo $toMB
