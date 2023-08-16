FROM ubuntu:20.04

# (Ubuntu 18.04: bionic, Ubuntu 20.04: focal)
ENV UBUNTU_VERSION=focal
# (Ubuntu 18.04: melodic, Ubuntu 20.04: noetic) 
ENV ROS_VERSION=noetic
# Wherever you want to install maplab)
ENV CATKIN_WS=/maplab_ws 

# Install ROS
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y software-properties-common wget
RUN wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | apt-key add -
RUN add-apt-repository "deb http://packages.ros.org/ros/ubuntu $UBUNTU_VERSION main"
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install ros-$ROS_VERSION-desktop-full "ros-$ROS_VERSION-tf2-*" "ros-$ROS_VERSION-camera-info-manager*" --yes

# Install framework dependencies.
RUN apt install -y autotools-dev ccache doxygen dh-autoreconf git \
                    liblapack-dev libblas-dev libgtest-dev libreadline-dev \
                    libssh2-1-dev pylint clang-format-12 python3-autopep8 \
                    python3 python3-catkin-tools python3-pip python-git-doc \
                    python3-setuptools python3-termcolor python3-wstool python3-rosdep \
                    libatlas3-base libv4l-dev libjpeg-dev --yes
RUN pip3 install --upgrade pip
RUN pip3 install requests opencv-python opencv-contrib-python

# Update ROS environment
RUN rosdep init
RUN rosdep update
RUN echo ". /opt/ros/$ROS_VERSION/setup.bash" >> ~/.bashrc

# Switch out the shell to bash
SHELL ["/bin/bash", "-c"]

# Use ccache
RUN source ~/.bashrc
RUN apt install -y ccache && echo 'export PATH="/usr/lib/ccache:$PATH"' | tee -a ~/.bashrc && source ~/.bashrc && echo $PATH
RUN ccache --max-size=10G

# GCC, probably unnecessary
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config

# Make a workspace
RUN mkdir -p $CATKIN_WS/src
WORKDIR $CATKIN_WS
RUN catkin init
RUN catkin config --merge-devel # Necessary for catkin_tools >= 0.4.
RUN catkin config --extend /opt/ros/$ROS_VERSION
RUN catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release

# Copy maplab repository from host to image
WORKDIR $CATKIN_WS/src
COPY maplab maplab

# Build maplab
WORKDIR $CATKIN_WS
RUN catkin build maplab