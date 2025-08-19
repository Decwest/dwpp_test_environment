FROM ubuntu:22.04
ARG USER=initial
ARG GROUP=initial
ARG UID=1000
ARG GID=${UID}
ARG SHELL=/bin/bash
ARG workspace=/

ENV ROS_DISTRO humble
ENV USER ${USER}


RUN echo base image: ${base_image}

#######################################################################
##                      install common packages                      ##
#######################################################################
ENV DEBIAN_FRONTEND=noninteractive
RUN apt update && apt install -y --no-install-recommends \
   pkg-config \
   apt-utils \
   wget \
   curl \
   git \
   build-essential \ 
   net-tools \
   gedit \
   terminator \
   nautilus \
   software-properties-common \
   apt-transport-https \
   libopencv-dev \
   ffmpeg \
   x264 \
   libx264-dev \
   zip \
   unzip \
   usbutils \
   sudo \
   python3-pip \
   libusb-1.0-0-dev \
   gnupg2 \
   lsb-release \
   ca-certificates \
   python3-setuptools \
   nano \
   iproute2 \
   x11-apps \
   dbus-x11

#######################################################################
##                            install ros2                           ##
#######################################################################
# Timezone, Launguage設定
RUN apt update \
  && apt install -y --no-install-recommends \
     locales \
     software-properties-common tzdata \
  && locale-gen en_US en_US.UTF-8 \
  && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
  && add-apt-repository universe

ENV LANG en_US.UTF-8
ENV TZ=Asia/Tokyo

# Install ROS2
RUN apt update

RUN apt update && apt install curl -y && \
    ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}') && \
    curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" && \
    dpkg -i /tmp/ros2-apt-source.deb

RUN apt update \
  && apt upgrade -y \
  && DEBIAN_FRONTEND=noninteractive \
  && apt install -y ros-$ROS_DISTRO-desktop \
  && rm -rf /var/lib/apt/lists/*

RUN apt update && apt install -y ros-dev-tools

RUN sh /opt/ros/$ROS_DISTRO/setup.sh

#######################################################################
##                            install nav2                           ##
#######################################################################
RUN apt update && apt install -y \
   ros-$ROS_DISTRO-navigation2 \
   ros-$ROS_DISTRO-nav2-bringup

#######################################################################
##                   install additional packages                     ##
#######################################################################

RUN apt install -y gazebo \
  && apt install -y ros-humble-gazebo-* \
  && apt install -y ros-humble-joint-state-publisher \
  && apt install -y ros-humble-rqt-* \
  && apt install -y ros-humble-turtlebot3*

#######################################################################
##                       install nvidia docker                       ##
#######################################################################
RUN distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
  && curl -s -L https://nvidia.github.io/libnvidia-container/gpgkey | apt-key add - \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

RUN apt update \
  && apt install -y --no-install-recommends nvidia-container-toolkit


#######################################################################
##                            delete cash                            ##
#######################################################################
RUN apt autoremove -y
RUN rm -rf /var/lib/apt/lists/*

######################################################################
#                         make sudoer user                          ##
######################################################################

ARG USER
ARG USER_ID
 
RUN groupadd -g 1000 developer && \
    useradd  -g      developer -G sudo -m -u ${UID} -s /bin/bash ${USER} && \
    echo "${USER}:${USER}" | chpasswd

RUN echo "Defaults visiblepw" >> /etc/sudoers
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

#######################################################################
##              make user accessible to usb and so on                ##
#######################################################################
RUN adduser ${USER} dialout
RUN adduser ${USER} tty
RUN adduser ${USER} video
RUN adduser ${USER} root

USER ${USER}

RUN echo "export PS1='\[\e[1;31;40m\]DWPP_DEV\[\e[0m\] \u:\w\$ '">> ~/.bashrc
RUN echo "source /initial_setting.sh">> ~/.bashrc

# setup workspace
ARG workspace
WORKDIR ${workspace}

RUN sudo rosdep init
RUN rosdep update
RUN bash /opt/ros/humble/setup.bash \
    && colcon build
