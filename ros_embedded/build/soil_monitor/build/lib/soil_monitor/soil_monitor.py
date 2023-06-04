import rclpy
from rclpy.node import Node
from time import sleep
from std_msgs.msg import String
import requests
import subprocess

class SoilSubscriber(Node):

    def __init__(self, name: str, value: str, host: str):
        super().__init__(name + '_soil')
        if name == '/':
            name = 'plant'
        self.alarm = False
        self.val = value
        self.host = host
        self.sub = self.create_subscription(
            String,
            '/%s/moisture' % name,
            self.compare_callback,
            10)


    def compare_callback(self, msg):

        print(msg.data)

        if int(msg.data) > int(self.val) :
            self.alarm = True
        else:
            self.alarm = False





def main(args = None):
    rclpy.init(args=args)

    moist_subscriber = SoilSubscriber("plant1", "50", "/dev/ttyACM0")
    
    while rclpy.ok():

        rclpy.spin_once(moist_subscriber, timeout_sec = 0.2)
        if  moist_subscriber.alarm:
            command = ['./src/soil_monitor/soil_monitor/serial_write.sh %s %s' % (moist_subscriber.host, 'on')]
            subprocess.run(command, shell=True)
            sleep(3600)

    
    moist_subscriber.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()
