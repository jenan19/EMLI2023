#!/usr/bin/gnuplot -persist
set title "Total amount of pump cycles"
set xlabel "Time"
set xtic auto 
set ytic auto 
#set xrange [-59:0]
set xrange [59:0]
set ylabel "Soil moisture [%]"
set terminal png size 400,400
set output '/var/www/html/Soil_moisture/current_data.png'; 
plot '< cat /home/pi/shell_scripts/soil/soil_data_latest.txt' with lines title 'Plant system 1' lw '3'





