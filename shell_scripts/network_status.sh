#!/bin/bash
memUsage=$(cat /proc/net/dev | awk '/eth0:/{print $2}')
echo $memUsage

