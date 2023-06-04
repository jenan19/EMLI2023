import rclpy
from rclpy.node import Node

from std_msgs.msg import String
import requests
import subprocess


class RemotePublisher(Node):

    def __init__(self):
        super().__init__('remote_reader')
        name = self.get_namespace()
        if name == '/':
            name = '/plant'
        
        self.timer = self.create_timer(0.5, self.timer_callback)
        self.publisher_ = self.create_publisher(String,name + '/pump', 10)
        self.host = 'http://10.42.0.22'

    def timer_callback(self):
        msg = String()
        #button_count = requests.get(self.host + '/button/a/count')
        command = ['./src/web_server/web_server/get_button.sh %s %s' % (self.host, "a")]

        button_count = subprocess.run(command, shell=True, stdout = subprocess.PIPE).stdout.decode('UTF8').strip().split('\n')[0]
        if(button_count == "1"):
            toggle = 'on'
        else:
            toggle = 'off'
        msg.data = toggle 
        self.publisher_.publish(msg)

class RemoteSubscriber(Node):

    def __init__(self, name: str, topic: str, value: str):
        super().__init__(name + '_' + topic)
        if name == '/':
            name = 'plant'
        self.alarm = False
        self.val = value
        self.sub = self.create_subscription(
            String,
            '/%s/%s' % (name, topic),
            self.compare_callback,
            10)


    def compare_callback(self, msg):
        
        print(msg.data)
        
        if int(msg.data) > int(self.val) :
            self.alarm = True
        else:
            self.alarm = False
    

def main(args=None):
    
    rclpy.init(args=args)

    remote_publisher = RemotePublisher()
    
    pump_subscriber = RemoteSubscriber("plant1", "pump_alarm", "0")
    water_subscriber = RemoteSubscriber("plant1", "water_alarm", "0")
    moist_subscriber = RemoteSubscriber("plant1", "moisture", "50")
    while rclpy.ok():

        rclpy.spin_once(remote_publisher)
        rclpy.spin_once(pump_subscriber, timeout_sec = 0.2)
        rclpy.spin_once(water_subscriber, timeout_sec = 0.2)
        rclpy.spin_once(moist_subscriber, timeout_sec = 0.2)
        toggle_red = "on" if  water_subscriber.alarm or pump_subscriber.alarm else "off"
        command = ['./src/web_server/web_server/set_led.sh %s %s %s' % (remote_publisher.host, "red", toggle_red)]
        subprocess.run(command, shell=True)
 
        toggle_yellow = "on" if  moist_subscriber.alarm and toggle_red == "off" else "off"
        command = ['./src/web_server/web_server/set_led.sh %s %s %s' % (remote_publisher.host, "yellow", toggle_yellow)]
        subprocess.run(command, shell=True)
        
        
        toggle_green = "on" if toggle_red == "off" and  toggle_yellow == "off" else "off"
        command = ['./src/web_server/web_server/set_led.sh %s %s %s' % (remote_publisher.host, "green", toggle_green)]
        subprocess.run(command, shell=True)
    # Destroy the node explicitly
    # (optional - otherwise it will be done automatically
    # when the garbage collector destroys the node object)
    remote_publisher.destroy_node()
    #remote_subscriber.destroy_node()
    rclpy.shutdown()


if __name__ == '__main__':
    main()

