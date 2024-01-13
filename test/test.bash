#!/bin/bash -xv
# SPDX-FileCopyrightText: 2023 Toshito Kimura
# SPDX-License-Identifire: BSD-3-Clause


dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build

source $dir/.bashrc

timeout 5 ros2 launch mypkg talk_listen.launch.py > /tmp/mypkg.log

ng () {
    echo "NG at Line $1"
    res=1
}

res=0

cat /tmp/mypkg.log |
grep "age:"

[ "$?" = 0 ] || ng $LINENO    

[ "$res" = 0 ] && echo "OK"
exit $res

