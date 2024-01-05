#!/bin/bash
# SPDX-FileCopyrightText: 2023 Toshito Kimura
# SPDX-License-Identifire: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build

source $dir/.bashrc

timeout 2 ros2 launch mypkg talk_listen.launch.py | grep 'age: 20'
