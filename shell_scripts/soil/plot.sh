#!/usr/bin/gnuplot -persist
set title "Soil Moisture"
set xlabel "Time"
set xtic auto 
set ytic auto 
#set xrange [-59:0]
set xrange [0:59]
set ylabel "Moisture [%]"
set terminal png size 400,400
set output '/var/www/html/Soil_moisture/current_data.png'; 
#plot '< tail -n 60 /home/pi/shell_scripts/light/light_data.txt' with lines title 'Plant system 1' lw '3'
plot '/home/pi/shell_scripts/soil/soil_data.txt' with lines title 'Plant system 1' lw '3'
