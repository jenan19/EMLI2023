pump=$(ros2 topic echo "$1"/pump_cycles --once | awk '/data:/{ gsub("\047", ""); print $2}')
error="Could not determine the type for the passed topic"
if [ $pump = $error ]; then
	pump=0
fi


echo $pump
