#!/bin/bash -xv
# SPDX-FileCopyrightText: 2023 Toshito Kimura
# SPDX-License-Identifire: BSD-3-Clause


dir=~
[ "$1" != "" ] && dir="$1"

source $dir/.bashrc

cd $dir/ros2_ws/src

git clone https://github.com/oO0x4x0Oo/person_msgs.git

cd $dir/ros2_ws
colcon build
source $dir/.bashrc

ros2 interface show "person_msgs/srv/Query"

cd $dir/ros2_ws
colcon build
source $dir/.bashrc

timeout 2 ros2 launch mypkg talk_listen.launch.py > /tmp/mypkg.log

ng () {
    echo "NG at Line $1"
    res=1
}

res=0

cat /tmp/mypkg.log |
grep ": 20"

[ "$?" = 0 ] || ng ${LINENO}

[ "$res" = 0 ] && echo "OK"
exit $res
