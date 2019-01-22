# ROS Gazebo Assets for race drone simulation
> Alberto S. Naranjo Galet. Dec. 2018.
> This project is licensed under the terms of the MIT license.

![Race Track](https://github.com/Veilkrand/gazebo_assets_drone_race/blob/master/images/default_gzclient_camera(1)-2018-12-05T13_20_12.687049.jpg)

Some assets to start simulating a simple drone race track in Gazebo. Markers are made using Aruco markers with a 4x4 dictionary. Dimensions are 0.5mx0.5m
To finish one lap you need to navigate the closest gate (from the front of the drone) and then land in the landing spot. For more than one lap the landing spot is a regular gate you need to pass 1 meter above.
Gate are solid and you can't cross them, use a point in space 1 meter above the center of the marker with the same pose.

## Instalation
Deploy in your Catkin workspace `/src` and build the packages `catkin build`. Source the workspace `$ . /devel/setup.bash`. Package name is `gazebo_assets_drone_race`.

## Launch world
Run `$ ./run_gazebo_world.sh` to launch Gazebo with `test_track.world` and the local models.

You can use the launch file to run Gazebo with the world model as well if you have sourced the new models:
`$ roslaunch gazebo_assets_drone_race test_track.world`

## Launch files
New launch file for testing the assets with Gazebo Rotors.

## Custom models
-- Aruco markers

## Aruco Markers 
Markers are made using Aruco markers with a 4x4 dictionary. Dimensions are 0.5mx0.5m

### Regular marker
Regular are gates are ID: 10.

### Landing spot / Race start 
Landing spots are ID: 7. They also function as a gate (e.g. pass 1 meter above the point) for more than 1 lap race. The landing spot pose is the same as the race start pose.

![Race Track](https://github.com/Veilkrand/gazebo_assets_drone_race/blob/master/images/default_gzclient_camera(1)-2018-12-05T13_20_42.093154.jpg)

----
##NOTES 

## Publish Waypoints to RotorS
`roslaunch gazebo_assets_race_drone test_rotors_waypoint.launch`

`rosrun rotors_gazebo waypoint_publisher 5 -5 3 0 0 __ns:=firefly`

## Python Trajectory
```
from trajectory_msgs.msg import MultiDOFJointTrajectory, MultiDOFJointTrajectoryPoint
from geometry_msgs.msg import Twist
from geometry_msgs.msg import Transform, Quaternion
import std_msgs.msg
from geometry_msgs.msg import Point
import tf

firefly_command_publisher = rospy.Publisher('/firefly/command/trajectory', MultiDOFJointTrajectory, queue_size=10)

desired_yaw_to_go_degree=-10

desired_x_to_go=2
desired_y_to_go=2.5
desired_z_to_go=2.5

quaternion = tf.transformations.quaternion_from_euler(0, 0, math.radians(desired_yaw_to_go_degree))

traj = MultiDOFJointTrajectory()

header = std_msgs.msg.Header()
header.stamp = rospy.Time()
header.frame_id = 'frame'
traj.joint_names.append('base_link')
traj.header=header

transforms =Transform(translation=Point(desired_x_to_go, desired_y_to_go, desired_z_to_go), rotation=Quaternion(quaternion[0],quaternion[1],quaternion[2],quaternion[3]))

velocities =Twist()
accelerations=Twist()
point = MultiDOFJointTrajectoryPoint([transforms],[velocities],[accelerations],rospy.Time(2))

traj.points.append(point)

time.sleep(1)
firefly_command_publisher.publish(traj)
```
