#!/usr/bin/gnuplot -persist
set title "Ambient Light"
set xlabel "Time"
set xtic auto 
set ytic auto 
#set xrange [-59:0]
set xrange [0:59]
set ylabel "Intensitivity [%]"
set terminal png size 400,400
set output '/var/www/html/ambient_light/current_data.png'; 
plot '< tail -n 60 /home/pi/shell_scripts/light/light_data.txt' with lines title 'Plant system 1' lw '3'
