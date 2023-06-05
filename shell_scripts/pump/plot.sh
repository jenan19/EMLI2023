#!/usr/bin/gnuplot -persist
set title "Total amount of pump cycles"
set xlabel "Time"
set xtic auto 
set ytic auto 
#set xrange [-59:0]
set xrange [59:0]
set ylabel "Pump cycles"
set terminal png size 400,400
set output '/var/www/html/pump_activations/current_data.png'; 
plot '< tail -n 60 /home/pi/shell_scripts/pump/pump_data_latest.txt' with lines title 'Plant system 1' lw '3'
