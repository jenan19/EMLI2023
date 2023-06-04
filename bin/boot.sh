#!/bin/bash
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
#export ROS_MASTER_URI=http://localhost:11311
cd ~/ros_embedded
source ~/ros_embedded/install/setup.bash
ros2 launch ~/ros_embedded/launch/plant_monitor.py
