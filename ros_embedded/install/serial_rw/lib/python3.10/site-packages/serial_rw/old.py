import rclpy
import subproccess
from rclpy.node import Node  
from std_msgs.msg import String
from time import sleep

class SerialCom(Node):

    TERMINATOR = '\n'.encode('UTF8')


    def __init__(self, device='/dev/ttyACM0', baud=115200, timeout=1):
        self.serial = serial.Serial(device, baud, timeout=timeout)
        



    def receive(self) -> str:
        line = self.serial.read_until(self.TERMINATOR)
        return line.decode('UTF8').strip()

    def send(self, text: str):
        line = '%s\n' % text
        self.serial.write(line.encode('UTF8'))


    def close(self):
        self.serial.close()


def main(args=None):
    
    rclpy.init(args=args)

    node = rclpy.create_node('serial_rw')
    moisture_pub = node.create_publisher(String, node.get_namespace() +'/moisture', 10)
    
    light_pub = node.create_publisher(String, node.get_namespace() +'/light', 10)
    

    
    pump_alarm_pub = node.create_publisher(String, node.get_namespace() +'/pump', 10)
    
    water_alarm_pub = node.create_publisher(String, node.get_namespace() +'/water', 10)

    moist = String()
    light = String()

    pump_alarm = String()
    water_alarm = String()

    serial_com = SerialCom()

    while rclpy.ok():
        data =  serial_com.receive()
        if (data != ""):
            moist.data = data.split(',')[0]
             
            light.data = data.split(',')[1]
            
            pump_alarm.data = data.split(',')[2]
            water_alarm.data = data.split(',')[3]

            moisture_pub.publish(moist)
            light_pub.publish(light)
            pump_alarm_pub.publish(pump_alarm)
            water_alarm_pub.publish(water_alarm)
        sleep(0.5)
        
    # Destroy the node explicitly
    # (optional - otherwise it will be done automatically
    # when the garbage collector destroys the node object)
    node.destroy_node()
    rclpy.shutdown()
    serial_com.close()

if __name__ == '__main__':
    main()
        

