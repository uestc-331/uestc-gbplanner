#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
from mavros_msgs.msg import RCIn
from quadrotor_msgs.msg import TakeoffLand
from std_msgs.msg import UInt32
import tty, select, sys, termios


class SimRemote:
    def __init__(self):
        # 初始化节点
        rospy.init_node("sim_remote")
        self.rate = rospy.Rate(30)
        
        # 初始化数据
        self.remote_msg = RCIn()
        self.takeoff_land_msg = TakeoffLand()
        
        self.remote_msg.header.frame_id = "world"
        self.remote_msg.channels = [1500] * 8
        for ch in [4, 5, 6, 7]:
            self.remote_msg.channels[ch] = 1000

        
        # 创建发布者
        # 遥控指令
        self.remote_pub = rospy.Publisher('iris_0/mavros/rc/in', RCIn, queue_size=1)
        # 起飞/降落指令--仅供特殊用途
        self.takeoff_land_pub = rospy.Publisher('/px4ctrl/takeoff_land', TakeoffLand, queue_size=1)
        self.mission_state_pub = rospy.Publisher('/mission_state', UInt32, queue_size=1, latch=True)

    def set_channel(self, channel, value):
        """设置遥控通道"""
        self.remote_msg.channels[channel] = value

    def pub_takeoff_msg(self, val):
        msg = TakeoffLand()
        msg.takeoff_land_cmd = val
        self.takeoff_land_pub.publish(msg)

    def pub_mission_state(self, val):
        msg = UInt32()
        msg.data = val
        self.mission_state_pub.publish(msg)

    def get_key(self):
        """获取键盘输入"""
        settings = termios.tcgetattr(sys.stdin)
        try:
            tty.setraw(sys.stdin.fileno())
            rlist, _, _ = select.select([sys.stdin], [], [], 0.1)
            if rlist:
                key = sys.stdin.read(1)
            else:
                key = ''
            return key
        finally:
            termios.tcsetattr(sys.stdin, termios.TCSADRAIN, settings)

    def print_menu(self):
        """打印操作菜单"""
        print("\n========== channels ==========")
        print("     |7|   |8|   |5|   |6|")
        print("     {0}  {1}  {2}  {3}".format(
            self.remote_msg.channels[6], 
            self.remote_msg.channels[7], 
            self.remote_msg.channels[4], 
            self.remote_msg.channels[5]))
        
        print("      r     t     y     u ")
        print("      f     g     h     j")
        print("            b     n")
        print("z to pub takeoff_land takeoff msg")
        print("c to pub takeoff_land land msg")
        print("'q' to quit")
        print("=====================================")

    def run(self):
        """主运行循环"""
        print("Sim Remote Started")
        self.print_menu()
        
        while not rospy.is_shutdown():
            key = self.get_key()
            
            if key == 'r':
                self.set_channel(6, 1000)
                self.print_menu()
            elif key == 'f':
                self.set_channel(6, 1999)
                self.print_menu()
                
            elif key == 't':
                self.set_channel(7, 1000)
                self.print_menu()
            elif key == 'g':
                self.set_channel(7, 1500)
                self.print_menu()
            elif key == 'b':
                self.set_channel(7, 1999)
                self.print_menu()
                
            elif key == 'y':
                self.set_channel(4, 1000)
                self.print_menu()
            elif key == 'h':
                self.set_channel(4, 1500)
                self.print_menu()
            elif key == 'n':
                self.set_channel(4, 1999)
                self.print_menu()
            
            elif key == 'u':
                self.set_channel(5, 1000)
                self.print_menu()
            elif key == 'j':
                self.set_channel(5, 1999)
                self.print_menu()
                
            elif key == 'z':
                self.pub_mission_state(4)
                rospy.sleep(0.1)
                self.pub_takeoff_msg(1)
            elif key == 'c':
                self.pub_takeoff_msg(2)
                
            elif key == 'q':
                print("Exiting...")
                break
            elif key != '':
                print("Invalid key.")
                
            self.remote_msg.header.stamp = rospy.Time.now()
            self.remote_pub.publish(self.remote_msg)
            # 控制循环频率
            self.rate.sleep()


if __name__ == '__main__':
    try:
        remote = SimRemote()
        remote.run()
    except rospy.ROSInterruptException:
        pass
    except Exception as e:
        print("Error occurred:", str(e))
