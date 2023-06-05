#!/usr/bin/gnuplot -persist

set title "Memory usage"
set xlabel "Time"
set xtic auto 
set ytic auto 
#set xrange [-59:0]
set xrange [59:0] 
set ylabel "Memory usage [MB]"
set terminal png size 400,400
set output '/var/www/html/Server_health/memory_data.png'; 
#plot '< tail -n 60 /home/pi/shell_scripts/memory/memory_data.txt' with lines title 'MB' 
plot '/home/pi/shell_scripts/memory/memory_usage_latest.txt' with lines title 'MB' lw '3'
