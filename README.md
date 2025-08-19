# dwpp_dev_environment

A Docker-based environment for developping DWPP Nav2 plugin (**ROS2 Humble**).

## Assumption

- Using Nvidia GPU
- Using Docker, Docker compose and nvidia container toolkit
- Using [Task](https://taskfile.dev/docs/installation) for command management

To install Task on Ubuntu:
```shell
sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
```

## Installation
1. Clone this repository

```shell
git clone https://github.com/Decwest/dwpp_dev_environment.git
```

2. Build the docker image
```shell
task build
```

3. Run the container
```shell
task run
```

## Running the Nav2 tutorial

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
