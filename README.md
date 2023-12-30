# mypkg

このROS2パッケージは、簡単なトーク・リスンノードの例を提供します。トークノードは名前に対して特定の年齢を返し、リスンノードはサービスを呼び出してその年齢を受け取ります。

![test](https://github.com/oO0x4x0Oo/mypkg/actions/workflows/test.yml/badge.svg)

# インストール
```
$ git clone git@github.com:oO0x4x0Oo/mypkg.git
$ colcon build
```

## talker.py

トークノードは、サービスサーバーを作成し、「name」に対する年齢情報を提供します。

```python
# talker.py

import rclpy
from rclpy.node import Node
from person_msgs.srv import Query

def cb(request, response):
    if request.name == "name":　　　　#←ここで名前を入力
        response.age = 20 　　　　　　#←ここで年齢を入力
    else:
        response.age = 255
    return response

rclpy.init()
node = Node("talker")
srv = node.create_service(Query, "query", cb)
rclpy.spin(node)
```

## listener.py

リスンノードは、サービスクライアントを作成し、トークノードに対してサービスを呼び出して年齢情報を取得します。

```python
# listener.py

import rclpy
from rclpy.node import Node
from person_msgs.srv import Query

def main():
    rclpy.init()
    node = Node("listener")
    client = node.create_client(Query, "query")
    while not client.wait_for_service(timeout_sec=1.0):
        node.get_logger().info('待機中')
    
    req = Query.Request()
    req.name = "name"                 #←ここで名前を入力
    future = client.call_async(req)
    
    # ...（略）...

if __name__ == '__main__':
    main()
```

## talk_listen.launch.py

トークノードとリスンノードを同時に起動するためのlaunchファイルです。

```python
# talk_listen.launch.py

import launch
import launch_ros.actions

def generate_launch_description():
    talker = launch_ros.actions.Node(
        package='mypkg',
        executable='talker',
    )
    listener = launch_ros.actions.Node(
        package='mypkg',
        executable='listener',
        output='screen'
    )

    return launch.LaunchDescription([talker, listener])
```

# 実行方法

## talker.pyとlistener.pyを使う場合

ターミナルを２つ起動する
* １つ目のターミナル（talker.py側）

```
$ ros2 run mypkg talker
(ここには何も表示されない)
```

* ２つ目のターミナル（listener.py側）

```
$ ros2 run mypkg listener
[INFO] [1703935056.727268261] [listener]: age: 20
```

設定した年齢が表示される

## talk_listen.launch.pyを使う場合
起動するターミナルは１つでよい

 ```
$ ros2 launch mypkg talk_listen.launch.py
[INFO] [launch]: All log files can be found below /home/toshito/.ros/log/2023-12-30-20-43-53-067163-DESKTOP-VOKTSCR-5811
[INFO] [launch]: Default logging verbosity is set to INFO
[INFO] [talker-1]: process started with pid [5813]
[INFO] [listener-2]: process started with pid [5815]
[listener-2] [INFO] [1703936633.569553271] [listener]: age: 20       #←ここに年齢が表示される
[INFO] [listener-2]: process has finished cleanly [pid 5815]
```

# 必要なソフトウェア
Python

# テスト環境
Ubuntu 20.04 on Windows
テストの際に以下のコンテナを使用しています
* [ryuichiueda/ubuntu22.04-ros2](https://hub.docker.com/repository/docker/ryuichiueda/ubuntu22.04-ros2)

# 著作権について
* このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．
* このパッケージのコードは，下記のスライド（CC-BY-SA 4.0 by Ryuichi Ueda）のものを，本人の許可を得て自身の著作としたものです．
     * [ryuichiueda/mypkg](https://github.com/ryuichiueda/mypkg)
* © 2023 Toshito Kimura
