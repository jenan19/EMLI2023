from dataclasses import dataclass
import rclpy
import subprocess
from rclpy.node import Node  
from std_msgs.msg import String
from time import sleep
import datetime

class LogData():

    def __init__(self, database) :
        self.data = 0
        self.database = database

    def write(self,data):
        self.data = data
        command = ['./src/database/database/write_log.sh %s %s' % (self.data, self.database)]
        subprocess.run(command, shell=True, stdout = subprocess.PIPE)

class MinimalSubscriber(Node):

    def __init__(self, name):
        # name = node.get_namespace()
        # if name == '/':
        #     name = 'plant'
        self.name = name
        self.value = 0
        super().__init__(self.name.replace("/", "_") + '_subscriber')
        self.subscription = self.create_subscription(
            String,
            self.name,
            self.listener_callback,
            10)
        self.subscription  # prevent unused variable warning

    def listener_callback(self, msg):
        self.value = ('%s' % msg.data)
    
    def get_value(self):
        return self.value



def main(args=None):

    rclpy.init(args=args)
    node = rclpy.create_node('database')
    
    name = node.get_namespace()
    if name == '/':
        name = 'plant'
    moisture_subscriber = MinimalSubscriber(name + '/moisture')
    light_subscriber = MinimalSubscriber(name + '/light')
    pump_subscriber = MinimalSubscriber(name + '/pump_cycles')
    pump_alarm_subscriber = MinimalSubscriber(name + '/pump_alarm')
    water_alarm_subscriber = MinimalSubscriber(name + '/water_alarm')
    moisture_logger = LogData("/var/www/html/Soil_moisture/log.txt")
    light_logger = LogData("/var/www/html/ambient_light/log.txt")
    pump_logger = LogData("/var/www/html/pump_activations/log.txt")
    pump_alarm_logger = LogData("/var/www/html/water_alarms/log1.txt")
    water_alarm_logger = LogData("/var/www/html/water_alarms/log2.txt")

    while rclpy.ok():
        rclpy.spin_once(moisture_subscriber, timeout_sec = 0.1)
        rclpy.spin_once(light_subscriber, timeout_sec = 0.1)
        rclpy.spin_once(pump_subscriber, timeout_sec = 0.1)
        rclpy.spin_once(pump_alarm_subscriber, timeout_sec = 0.1)
        rclpy.spin_once(water_alarm_subscriber, timeout_sec = 0.1)

        current_time = datetime.datetime.now()

        moisture_logger.write('"'+ name + '/moisture' + ", " + str(current_time) + ", " + str(moisture_subscriber.get_value()) +'"')
        light_logger.write('"' + name + '/light' + ", "+ str(current_time)+", "+ str(light_subscriber.get_value()) +  '"')
        pump_logger.write('"' + name + '/pump'+ ", "+ str(current_time) + ", " + str(pump_subscriber.get_value())+'"')
        pump_alarm_logger.write('"' + name + '/pump_alarm'+ ", " + str(current_time) + ", " + str(pump_alarm_subscriber.get_value())+'"')
        water_alarm_logger.write('"' + name + '/water_alarm'+ ", " + str(current_time) + ", " + str(water_alarm_subscriber.get_value())+'"')
        # print(moisture_subscriber.get_value())
        # print(light_subscriber.get_value())
        # print(pump_subscriber.get_value())
        # print(pump_alarm_subscriber.get_value())
        # print(water_alarm_subscriber.get_value())
        
        sleep(5)
    moisture_subscriber.destroy_node()
    rclpy.shutdown()
if __name__ == '__main__':
    main()
