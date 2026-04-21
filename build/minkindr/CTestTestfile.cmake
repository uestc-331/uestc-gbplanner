# CMake generated Testfile for 
# Source directory: /home/super/uestc-gbplanner/src/misc/minkindr/minkindr
# Build directory: /home/super/uestc-gbplanner/build/minkindr
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_minkindr_gtest_minkindr_tests "/home/super/uestc-gbplanner/build/minkindr/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/home/super/uestc-gbplanner/build/minkindr/test_results/minkindr/gtest-minkindr_tests.xml" "--return-code" "/home/super/uestc-gbplanner/devel/.private/minkindr/lib/minkindr/minkindr_tests --gtest_output=xml:/home/super/uestc-gbplanner/build/minkindr/test_results/minkindr/gtest-minkindr_tests.xml")
set_tests_properties(_ctest_minkindr_gtest_minkindr_tests PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/catkin/cmake/test/gtest.cmake;98;catkin_run_tests_target;/opt/ros/noetic/share/catkin/cmake/test/gtest.cmake;37;_catkin_add_google_test;/home/super/uestc-gbplanner/src/misc/minkindr/minkindr/CMakeLists.txt;9;catkin_add_gtest;/home/super/uestc-gbplanner/src/misc/minkindr/minkindr/CMakeLists.txt;0;")
subdirs("gtest")
