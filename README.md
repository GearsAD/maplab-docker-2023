# MapLab Docker Image

Docker image for MapLab that uses the latest code and an Ubuntu 20.04 parent image.

This is used for sandboxing and development. It will clone the MapLab repo to `./maplab`, copy it to the image, and map `./datasets` from the host system to the image. When you run it, it will provide a bash prompt (there is no overridden start command, but feel free to add one). 

Feel free to reach out if you're trying it or have any issues.

## Installation

- Pull the repository
- Run `make all` to build the Docker image named `maplab:latest`

## Running the image

- Run `make run` on the host system

Inside the image:
- Source the workspace: `source /maplab_ws/devel/setup.bash`
- Start ROSCore: `roscore&`
- Run maplab: `rosrun maplab_console maplab_console`