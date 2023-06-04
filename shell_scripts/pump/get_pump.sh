pump=$(ros2 topic echo "$1"/pump --once | awk '/data:/{ gsub("\047", ""); print $2}')

if [ $pump = "on" ]; then
	value=1
else
	value=0
fi

echo $value
