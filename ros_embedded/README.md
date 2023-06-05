# Source ros
cd ros_embedded 

source install/setup.bash

# To build 
cd ros_embedded

colcon build

# To run
cd ros_embedded

ros2 launch launch/plant_monitor.py

# Run a node from a package
cd ros_embedded

ros2 run <package> <node>





