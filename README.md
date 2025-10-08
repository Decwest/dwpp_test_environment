# dwpp_test_environment

[![ROS2 Distro: Humble](https://img.shields.io/badge/ROS2-Humble-blue.svg)](https://docs.ros.org/en/humble/index.html) [![Docker](https://img.shields.io/badge/Docker-blue.svg)](https://www.docker.com/)

A **Docker-based environment** for testing the DWPP Nav2 plugin (**ROS2 Humble**).

This repository provides:
- 📘 Simulations for comparing **DWPP** with conventional methods  
- 🚀 Nav2 tutorials that run with **DWPP**


## Assumptions

- Docker & Docker Compose for creating the virtual environment  
- [Task](https://taskfile.dev/docs/installation) for command management  
- (Optional) Nvidia GPU with `nvidia-container-toolkit` if GPU is available  

To install Task on Ubuntu:

```shell
sudo sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/local/bin
```

## Installation
1. **Clone this repository**

```shell
git clone --recursive https://github.com/Decwest/dwpp_test_environment.git
```

2. **Build the docker image**

```shell
task build
```

3. **Run the container**

- CPU only:
```shell
task run.cpu
```

- With GPU:
```shell
task run.gpu
```

4. **Build the `nav2_dynamic_window_pure_pursuit_controller` package**

Inside the Docker terminal:
```shell
colcon build --symlink-install
```

For the first build only:
```shell
source install/local_setup.bash
```

## Running Method Comparison Simulation

```shell
ros2 launch nav2_dynamic_window_pure_pursuit_controller dwpp_test.launch.py
```

👉 Try out different pure pursuit methods on several example path-tracking scenarios.

Controller parameters are defined here:
[🔗 test_params.yaml](https://github.com/Decwest/nav2_dynamic_window_pure_pursuit_controller/blob/main/config/test_params.yaml)

https://github.com/user-attachments/assets/8b3e64e7-5934-4c60-92d2-49a889062489

## Running the Nav2 Tutorial with DWPP

1. **Launch the Nav2 tutorial**

> ⚠️ The first time, Gazebo may take a while to start because it needs to download models. Please wait patiently.


```shell
ros2 launch nav2_bringup tb3_simulation_launch.py params_file:=$(ros2 pkg prefix nav2_dynamic_window_pure_pursuit_controller)/share/nav2_dynamic_window_pure_pursuit_controller/config/example_dwpp_params.yaml headless:=False
```

If the download seems stuck, start Gazebo manually:

```shell
gazebo
```

Then, from the *Insert* tab, load **TurtleBot3 (Waffle)** and **TurtleBot3 World**.

2. **Set the initial pose** using the *2D Pose Estimate* panel in RViz2 (**important**).
3. **Set a goal pose** using the *Nav2 Goal* panel in RViz2. Nav2 should now start navigating! 🚀

Controller parameters are defined here:
[🔗 example_dwpp_params.yaml](https://github.com/Decwest/nav2_dynamic_window_pure_pursuit_controller/blob/main/config/example_dwpp_params.yaml)

https://github.com/user-attachments/assets/434e6628-9866-43c6-9e35-642a3f0e2842
