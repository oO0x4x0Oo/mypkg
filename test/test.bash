#!/bin/bash
# SPDX-FileCopyrightText: 2023 Toshito Kimura
# SPDX-License-Identifire: BSD-3-Clause

dir=~
[ "$1" != "" ] && dir="$1"

cd $dir/ros2_ws
colcon build

source $dir/.bashrc

timeout 5 ros2 launch mypkg talk_listen.launch.py &> /tmp/mypkg.log &

sleep 2

python3 $dir/ros2_ws/src/mypkg/mypkg/listener.py

listener_exit_code=$?

ros2 node kill /talker
ros2 node kill /listener

cat /tmp/mypkg.log

if [ $listener_exit_code -eq 0 ]; then
  echo "テスト成功：ログファイルに 'age: 20' が見つかりました。"
else
  echo "テスト失敗：ログファイルに 'age: 20' が見つかりませんでした。"
fi

