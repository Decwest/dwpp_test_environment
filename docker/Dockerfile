FROM osrf/ros:humble-desktop-full
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
  && apt install -y ros-humble-turtlebot3* \
  && apt install -y python3-colcon-clean

#######################################################################
##                            delete cash                            ##
#######################################################################
RUN apt autoremove -y
RUN rm -rf /var/lib/apt/lists/*

######################################################################
#                         make sudoer user                          ##
######################################################################

ARG USER=developer
ARG UID=1000
ARG GID=1000
ARG GROUP=developer

RUN set -eux; \
    if getent passwd "${UID}" >/dev/null; then \
      existing_user="$(getent passwd "${UID}" | cut -d: -f1)"; \
      [ "${existing_user}" = "${USER}" ] || { echo "UID ${UID} は ${existing_user} が使用中。USER=${USER} と矛盾"; exit 66; }; \
    else \
      if ! getent group "${GID}" >/dev/null; then groupadd -g "${GID}" "${GROUP}"; fi; \
      useradd -m -u "${UID}" -g "${GID}" -s /bin/bash "${USER}"; \
    fi; \
    usermod -aG sudo "${USER}"; \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USER}; \
    chmod 0440 /etc/sudoers.d/${USER}; \
    visudo -cf /etc/sudoers

#######################################################################
##              make user accessible to usb and so on                ##
#######################################################################
RUN adduser ${USER} dialout
RUN adduser ${USER} tty
RUN adduser ${USER} video
RUN adduser ${USER} root

USER ${USER}

RUN echo "export PS1='\[\e[1;31;40m\]HUMBLE\[\e[0m\] \u:\w\$ '">> ~/.bashrc
RUN echo "source /initial_setting.sh">> ~/.bashrc

# setup workspace
ARG workspace
WORKDIR ${workspace}

# RUN sudo rosdep init
RUN rosdep update
RUN bash /opt/ros/$ROS_DISTRO/setup.bash \
    && colcon build
