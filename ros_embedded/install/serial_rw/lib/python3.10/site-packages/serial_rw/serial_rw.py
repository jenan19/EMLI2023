import rclpy
import subprocess
from rclpy.node import Node  
from std_msgs.msg import String
from time import sleep

class SerialCom(Node):


    def __init__(self):
        self.port = '/dev/ttyACM0'
        self.baud_rate = '115200'


    def receive(self) -> str:
        command = ['./src/serial_rw/serial_rw/serial_read.sh %s %s' % (self.port, self.baud_rate)]
        line = subprocess.run(command, shell=True, stdout = subprocess.PIPE)
        #print('reading: "%s"' % line.stdout.decode('UTF8').strip().split('\n'))
        return line.stdout.decode('UTF8').strip().split('\n')

    def send(self, text: str):
        command = ['./src/serial_rw/serial_rw/serial_write.sh %s %s' % (self.port, text)]
        out_put = subprocess.run(command, shell=True, stdout = subprocess.PIPE)
        print(out_put.stdout) 

    def close(self):
        self.serial.close()




class PumpSubscriber(Node):
    def __init__(self):
        super().__init__('pump_subscriber')
        name = self.get_namespace()
        if name == '/':
            name = '/plant'
        self.pump = "off" 
        self.pump_sub = self.create_subscription(
            String,
            name + '/pump',
            self.pump_callback,
            10)

    def pump_callback(self, msg):
        sleep(0.1)
        if msg.data == "on":
            self.pump = "on"
        else:
            self.pump = "off"




def main(args=None):
    
    rclpy.init(args=args)

    node = rclpy.create_node('serial_rw')
    
    name = node.get_namespace()
    if name == '/':
        name = 'plant'

    moisture_pub = node.create_publisher(String, name +'/moisture', 10)
    
    light_pub = node.create_publisher(String,  name +'/light', 10)
    
    
    pump_alarm_pub = node.create_publisher(String, name +'/pump_alarm', 10)
    
    pump_cycles = node.create_publisher(String, name +'/pump_cycles', 10)

    water_alarm_pub = node.create_publisher(String, name +'/water_alarm', 10)

    moist = String()
    light = String()
    cycles = String()
    pump_alarm = String()
    water_alarm = String()

    serial_com = SerialCom()
    
    pump_monitor = PumpSubscriber()

    pumps = 0

    while rclpy.ok():
        try: 
            data =  serial_com.receive()[-1]
            print(data)
            if (data != ""):
                recv = data.split(',')
                moist.data = recv[2]
             
                light.data = recv[3]
            
                pump_alarm.data = recv[0]
                water_alarm.data = recv[1]

                moisture_pub.publish(moist)
                light_pub.publish(light)
                pump_alarm_pub.publish(pump_alarm)
                water_alarm_pub.publish(water_alarm)
        except:
            print("read failed")

        rclpy.spin_once(pump_monitor, timeout_sec = 0.1)
        print(pump_alarm)
        if pump_alarm.data == '0'  and water_alarm.data == '0' and pump_monitor.pump == "on":
            serial_com.send(text = "on")
            pumps += 1
        cycles.data = str(pumps)
        pump_cycles.publish(cycles)

    # Destroy the node explicitly
    # (optional - otherwise it will be done automatically
    # when the garbage collector destroys the node object)
    node.destroy_node()
    rclpy.shutdown()
    serial_com.close()

if __name__ == '__main__':
    main()
        

