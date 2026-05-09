#!/usr/bin/env python
# -*- coding: utf-8 -*-

import rospy
from mavros_msgs.msg import State
from mavros_msgs.srv import CommandBool, SetMode
import tty, select, sys, termios
from std_srvs.srv import Empty


class UAVArmControl:
    def __init__(self):
        # 初始化节点
        rospy.init_node("uav_arm_control")
        self.rate = rospy.Rate(50)
        
        # 获取参数
        self.vehicle_type = rospy.get_param("~vehicle_type", "iris")
        self.vehicle_id = rospy.get_param("~vehicle_id", "0")
        
        # 完整的无人机名称
        self.vehicle_name = "{}_{}".format(self.vehicle_type, self.vehicle_id)
        
        # 等待飞控连接
        try:
            mavros_state = rospy.wait_for_message("/{}/mavros/state".format(self.vehicle_name), State, timeout=10)
            rospy.loginfo("{}: Successfully connected to FCU".format(self.vehicle_name))
        except rospy.ROSException:
            rospy.logerr("{}: No connection to FCU. Check mavros!".format(self.vehicle_name))
            exit(1)

        # 创建服务代理
        self.arm_service = rospy.ServiceProxy("/{}/mavros/cmd/arming".format(self.vehicle_name), CommandBool)
        self.flightModeService = rospy.ServiceProxy("/{}/mavros/set_mode".format(self.vehicle_name), SetMode)
        
        # 订阅状态话题
        self.state_sub = rospy.Subscriber("/{}/mavros/state".format(self.vehicle_name), State, self.state_callback)
        self.current_state = None
        
        rospy.loginfo("UAV Arm Control initialized for {}".format(self.vehicle_name))

    def state_callback(self, state_msg):
        """状态回调函数"""
        self.current_state = state_msg

    def arm(self):
        """解锁无人机"""
        try:
            response = self.arm_service(True)
            if response.success:
                rospy.loginfo("UAV armed successfully!")
                return True
            else:
                rospy.logerr("Failed to arm UAV!")
                return False
        except rospy.ServiceException as e:
            rospy.logerr("Service call failed: %s" % e)
            return False

    def disarm(self):
        """上锁无人机"""
        try:
            response = self.arm_service(False)
            if response.success:
                rospy.loginfo("UAV disarmed successfully!")
                return True
            else:
                rospy.logerr("Failed to disarm UAV!")
                return False
        except rospy.ServiceException as e:
            rospy.logerr("Service call failed: %s" % e)
            return False
        
    def flight_mode_switch(self, mode):
        if self.flightModeService(custom_mode = mode):
            rospy.loginfo("UAV switched to {} mode successfully!".format(mode))
            return True
        else:
            rospy.logerr("Switch Failed!")
            return False
            
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
        print("\n========== UAV Control Menu ==========")
        print("a - Arm (解锁)")
        print("d - Disarm (上锁)")
        print("o - offboard mode (板外)")
        print("h - hover mode (悬停)")
        print("s - Show Status (显示状态)")
        print("q - Quit (退出)")
        print("=====================================")
        
        if self.current_state:
            print("Current Status - Connected: {}, Armed: {}, Mode: {}".format(
                self.current_state.connected,
                self.current_state.armed,
                self.current_state.mode))
    def run(self):
        """主运行循环"""
        print("UAV Arm Control Started")
        self.print_menu()
        
        while not rospy.is_shutdown():
            key = self.get_key()
            
            if key == 'a':
                self.arm()
            elif key == 'd':
                self.disarm()
            elif key == 'o':
                self.flight_mode_switch('OFFBOARD')
            elif key == 'h':
                self.flight_mode_switch('LOITER')
            elif key == 's':
                self.print_menu()
            elif key == 'q':
                print("Exiting...")
                break
            elif key != '':
                print("Invalid key.")
                
            # 控制循环频率
            self.rate.sleep()


if __name__ == '__main__':
    try:
        controller = UAVArmControl()
        controller.run()
    except rospy.ROSInterruptException:
        pass
    except Exception as e:
        print("Error occurred:", str(e))