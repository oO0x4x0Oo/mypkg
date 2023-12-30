# mypkg

このROS2パッケージは、簡単なトーク・リスンノードの例を提供します。トークノードは名前に対して特定の年齢を返し、リスンノードはサービスを呼び出してその年齢を受け取ります。

![test](https://github.com/oO0x4x0Oo/mypkg/actions/workflows/test.yml/badge.svg)

## install
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
