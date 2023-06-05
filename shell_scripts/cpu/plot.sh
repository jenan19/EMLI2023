#!/usr/bin/gnuplot -persist

set title "CPU Temparature"
set xlabel "Time"
set xtic auto 
set ytic auto 
#set xrange [-59:0]
set xrange [59:0]
set ylabel "CPU temp [°C]"
set terminal png size 400,400
set output '/var/www/html/Server_health/current_data.png'; 
plot '< tail -n 60 /home/pi/shell_scripts/cpu/cpu_temp_latest.txt' with lines title '°C' lw '3'
