#!/bin/bash

# PCI服务诊断脚本
# 用于诊断为什么服务不可用

echo "=========================================="
echo "PCI服务诊断工具"
echo "=========================================="
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. 检查节点是否运行
echo "1. 检查节点状态..."
echo "----------------------------------------"
if rosnode list | grep -q "pci_general_ros_node"; then
    echo -e "${GREEN}✓ pci_general_ros_node 节点正在运行${NC}"
    echo ""
    echo "节点详细信息:"
    rosnode info /pci_general_ros_node | head -20
else
    echo -e "${RED}✗ pci_general_ros_node 节点未运行！${NC}"
    echo ""
    echo "所有运行的节点:"
    rosnode list
    echo ""
    echo -e "${YELLOW}请检查launch文件是否正确启动了pci_general_ros_node${NC}"
fi
echo ""

# 2. 检查服务列表
echo "2. 检查服务列表..."
echo "----------------------------------------"
SERVICES=$(rosservice list | grep planner_control_interface)
if [ -z "$SERVICES" ]; then
    echo -e "${RED}✗ 没有找到 planner_control_interface 相关的服务${NC}"
    echo ""
    echo "所有可用的服务:"
    rosservice list | head -20
else
    echo -e "${GREEN}✓ 找到以下服务:${NC}"
    echo "$SERVICES"
fi
echo ""

# 3. 检查特定服务
echo "3. 检查特定服务..."
echo "----------------------------------------"
SERVICE_NAME="/planner_control_interface/std_srvs/automatic_planning"
if rosservice list | grep -q "$SERVICE_NAME"; then
    echo -e "${GREEN}✓ 服务存在: $SERVICE_NAME${NC}"
    echo ""
    echo "服务信息:"
    rosservice info "$SERVICE_NAME"
else
    echo -e "${RED}✗ 服务不存在: $SERVICE_NAME${NC}"
    echo ""
    echo "类似的服务:"
    rosservice list | grep -i "automatic\|planning\|planner" | head -10
fi
echo ""

# 4. 检查话题
echo "4. 检查相关话题..."
echo "----------------------------------------"
TOPICS=$(rostopic list | grep -E "(gbplanner|pci|planner)")
if [ -z "$TOPICS" ]; then
    echo -e "${YELLOW}⚠ 没有找到相关话题${NC}"
else
    echo -e "${GREEN}✓ 找到以下话题:${NC}"
    echo "$TOPICS" | head -10
fi
echo ""

# 5. 检查ROS Master连接
echo "5. 检查ROS Master连接..."
echo "----------------------------------------"
if rostopic list > /dev/null 2>&1; then
    echo -e "${GREEN}✓ 成功连接到ROS Master${NC}"
    echo "ROS_MASTER_URI: $ROS_MASTER_URI"
else
    echo -e "${RED}✗ 无法连接到ROS Master${NC}"
    echo "ROS_MASTER_URI: $ROS_MASTER_URI"
fi
echo ""

# 6. 检查节点日志（如果可能）
echo "6. 建议检查项..."
echo "----------------------------------------"
echo "1. 检查pci_general_ros_node的启动日志，查看是否有错误"
echo "2. 确认launch文件中pci_general_ros_node节点已启动"
echo "3. 检查节点是否在等待某些条件（如odometry）"
echo "4. 查看节点输出中是否有 'PCI: connected to service planner_server' 消息"
echo ""

# 7. 提供解决方案
echo "=========================================="
echo "可能的解决方案"
echo "=========================================="
echo ""
echo "如果节点未运行:"
echo "  1. 检查launch文件是否正确"
echo "  2. 检查是否有编译错误"
echo "  3. 重新编译工作空间: catkin_make"
echo ""
echo "如果节点运行但服务不存在:"
echo "  1. 检查节点日志，查看服务注册是否失败"
echo "  2. 确认节点是否在等待其他服务（如gbplanner服务）"
echo "  3. 检查节点命名空间是否正确"
echo ""
echo "如果服务名称不同:"
echo "  1. 使用以下命令查找实际服务名称:"
echo "     rosservice list | grep -i planner"
echo "  2. 检查launch文件中的remap设置"
echo ""


