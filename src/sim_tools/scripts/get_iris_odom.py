import rospy
from geometry_msgs.msg import PoseStamped, Vector3Stamped
from nav_msgs.msg import Odometry
import sys
from gazebo_msgs.msg import ModelStates

vehicle_type = rospy.get_param('vehicle_type', default='iris')
odom_pub = [None]
odom = Odometry()

def gazebo_model_state_callback(msg):
    id = msg.name.index(vehicle_type)

    odom.header.stamp = rospy.Time().now()
    odom.header.frame_id = 'world'
    odom.pose.pose = msg.pose[id]
    odom.twist.twist = msg.twist[id]

if __name__ == '__main__':
    rospy.init_node(vehicle_type+'_get_pose_groundtruth')
    gazebo_model_state_sub = rospy.Subscriber("/gazebo/model_states", ModelStates, gazebo_model_state_callback,queue_size=1)
    
    odom_pub = rospy.Publisher(vehicle_type + '/sim_tool/odometry', Odometry, queue_size=1)
    print("Get " + vehicle_type + " groundtruth pose")
    rate = rospy.Rate(30)
    while not rospy.is_shutdown():
        odom_pub.publish(odom)
        try:
            rate.sleep()
        except:
            continue

