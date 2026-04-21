cmake_minimum_required(VERSION 2.8.3)
project(yaml_cpp_catkin)

find_package(catkin_simple REQUIRED)
catkin_simple()

find_package(yaml-cpp REQUIRED)

cs_export(INCLUDE_DIRS ${YAML_CPP_INCLUDE_DIRS}
          LIBRARIES yaml-cpp)
