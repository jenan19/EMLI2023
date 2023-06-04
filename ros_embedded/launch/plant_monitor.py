from launch import LaunchDescription
from launch_ros.actions import Node

def generate_launch_description():
    return LaunchDescription([
        Node(
            package='serial_rw',
            namespace='plant1',
            executable='rw',
            name='rw'
        ),
        Node(
            package='web_server',
            namespace='plant1',
            executable='web_server',
            name='web_server1'
        ),
        Node(
            package='soil_monitor',
            namespace='plant1',
            executable='soil_monitor',
            name='soil_monitor'
            ),
        Node(
            package='database',
            namespace='plant1',
            executable='database_updater',
            name='database1'
            )
    ])
