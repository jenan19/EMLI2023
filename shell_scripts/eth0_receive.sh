#!/bin/bash
memUsage=$(cat /proc/net/dev | awk '/eth0:/{print $2}')
toMB=$(expr $memUsage / 1000000)
echo $toMB
