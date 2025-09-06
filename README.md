# dwpp_test_environment

A Docker-based environment for testing DWPP Nav2 plugin (**ROS2 Humble**).

## Assumption

- Using Docker, Docker compose for creating virtual environment
- Using [Task](https://taskfile.dev/docs/installation) for command management
- If you have GPU: using Nvidia GPU and nvidia-container-toolkit

To install Task on Ubuntu:
```shell
sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
```

## Installation
1. Clone this repository

```shell
git clone https://github.com/Decwest/dwpp_test_environment.git
```

2. Build the docker image

- If you only have cpu:
```shell
task build.cpu
```

- If you have gpu:
```shell
task build.gpu
```

1. Run the container

- If you only have cpu:
```shell
task run.cpu
```

- If you have gpu:
```shell
task run.gpu
```

## Running the DWPP tutorial

1. Launch the Nav2 tutorial:

> ⚠️ The first time, Gazebo may take a while to start because it needs to download models. Please wait patiently.


```shell
ros2 launch nav2_bringup tb3_simulation_launch.py headless:=False
```

If the download seems stuck, you can start Gazebo manually by typing:

```shell
gazebo
```

Then, from the *Insert* tab, load **TurtleBot3 (Waffle)** and **TurtleBot3 World**.

2. **Set the initial pose** using the *2D Pose Estimate* panel in RViz2 (**important**).
3. Set a goal pose using the *Nav2 Goal* panel in RViz2. Nav2 should now start navigating! 🚀
