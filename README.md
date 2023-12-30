# mypkg

このROS2パッケージは、簡単なトーク・リスンノードの例を提供します。トークノードは「木村秋仁」という名前に対して特定の年齢を返し、リスンノードはサービスを呼び出してその年齢を受け取ります。

![test](https://github.com/oO0x4x0Oo/mypkg/actions/workflows/test.yml/badge.svg)

## talker.py

トークノードは、サービスサーバーを作成し、「木村秋仁」に対する年齢情報を提供します。

```python
# talker.py

import rclpy
from rclpy.node import Node
from person_msgs.srv import Query

def cb(request, response):
    if request.name == "木村秋仁":
        response.age = 20
    else:
        response.age = 255
    return response

rclpy.init()
node = Node("talker")
srv = node.create_service(Query, "query", cb)
rclpy.spin(node)



