# Embedded Linux - Plant watering system

This repository implements a plant watering system. It utilises shell, and crontab for most functionalities. It relies on ROS2 for inter-process communication and node management. If installed on a system by moving /html into /var/www, and the crontab function located in /shell_scripts/backup_corntab.txt are added the systems crotab file it wil run as intended. 

## Structure

In the bin folder are all of the boot scripts.

The html folder contains the html scripts that make the webinterface.

The ros_embedded folder contains the ros workspace.

The shell_scripts folder contains the shell scripts called by the Crontab, the webinterface, the boot sequence and the ROS scripts.
