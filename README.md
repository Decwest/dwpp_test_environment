# dwpp_test_environment

[![ROS2 Distro: Rolling](https://img.shields.io/badge/ROS2-Rolling-green.svg)](https://docs.ros.org/en/rolling/index.html) [![Docker](https://img.shields.io/badge/Docker-blue.svg)](https://www.docker.com/)

A **Docker-based environment** for developing **Nav2 official implementation of DWPP** (**ROS2 Rolling**).

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
git clone -b feature/nav2_integration --recursive https://github.com/Decwest/dwpp_test_environment.git
```

2. **Build the docker image**

```shell
task build.rolling
```

1. **Run the container**

- With GPU:
```shell
task run.rolling.gpu
```

- CPU only:
```shell
task run.rolling.cpu
```

1. **Build packages**

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
ros2 launch dwpp_test_simulation dwpp_test.launch.py
```

👉 Try out different pure pursuit methods on several example path-tracking scenarios.

Controller parameters are defined here:
[🔗 test_params.yaml](https://github.com/Decwest/dwpp_test_simulation/blob/main/params/test_params.yaml)

https://github.com/user-attachments/assets/8b3e64e7-5934-4c60-92d2-49a889062489

## Running the Nav2 Tutorial with DWPP

1. **Launch the Nav2 tutorial**

```shell
ros2 launch nav2_bringup tb3_simulation_launch.py params_file:=$(ros2 pkg prefix dwpp_test_simulation)/share/dwpp_test_simulation/params/example_dwpp_params.yaml headless:=False
```
2. **Set the initial pose** using the *2D Pose Estimate* panel in RViz2 (**important**).
3. **Set a goal pose** using the *Nav2 Goal* panel in RViz2. Nav2 should now start navigating! 🚀

Controller parameters are defined here:
[🔗 example_dwpp_params.yaml](https://github.com/Decwest/dwpp_test_simulation/blob/main/params/example_dwpp_params.yaml)

https://github.com/user-attachments/assets/434e6628-9866-43c6-9e35-642a3f0e2842
