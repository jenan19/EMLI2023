#!/bin/bash
memUsage=$(free -m | awk '/Mem/{print $3}')
memTotal=$(free -m | awk '/Mem/{print $2}')
memFree=$(free -m | awk '/Mem/{print $4}')
menLeftMB=$(expr $memTotal - $memUsage)
mentMB=$(expr $memFree / 3790 \* 100)
menProcent=$(expr $mentMB \* 100)
echo "$memUsage"
