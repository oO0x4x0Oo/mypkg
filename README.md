# mypkg

このROS2パッケージは、簡単なtalker, listenerの例です。talkerは名前に対して特定の年齢を発信し、listenerはその年齢を受け取ります。

![test](https://github.com/oO0x4x0Oo/mypkg/actions/workflows/test.yml/badge.svg)

## talker.py

talkerは、「name」に対する年齢情報を発信します。

## listener.py

listenerは、talkerを呼び出して年齢情報を取得します。

## talk_listen.launch.py

talkerとlistenerを同時に起動するためのlaunchファイルです。

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

ROS2 Foxy Fitzroy

# テスト環境
Ubuntu 22.04 on Windows

テストの際に以下のコンテナを使用しています
* [ryuichiueda/ubuntu22.04-ros2](https://hub.docker.com/repository/docker/ryuichiueda/ubuntu22.04-ros2)

# 著作権について
* このソフトウェアパッケージは，3条項BSDライセンスの下，再頒布および使用が許可されます．
* このパッケージのコードは，下記のスライド（CC-BY-SA 4.0 by Ryuichi Ueda）のものを，本人の許可を得て使用したものです．
     * [ryuichiueda/mypkg](https://github.com/ryuichiueda/mypkg)
* © 2023 Toshito Kimura
