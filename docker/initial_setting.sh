#!/bin/bash

## source
source "/opt/ros/$ROS_DISTRO/setup.bash"
source ~/ros2_ws/install/local_setup.bash
source /usr/share/gazebo/setup.sh

export TURTLEBOT3_MODEL=waffle  # Iron and older only with Gazebo Classic
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/opt/ros/$ROS_DISTRO/share/turtlebot3_gazebo/models # Iron and older only with Gazebo Classic

alias cb="colcon build --symlink-install"
alias cc="colcon clean workspace"
