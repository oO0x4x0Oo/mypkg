# SPDX-FileCopyrightText: 2023 Toshito Kimura
# SPDX-License-Identifire: BSD-3-Clause

import launch
import launch.actions
import launch.substitutions
import launch_ros.actions


def generate_launch_description():

<<<<<<< HEAD
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
=======
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
>>>>>>> lesson10
