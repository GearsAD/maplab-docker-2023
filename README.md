# MapLab Docker Image

Docker image for MapLab that uses the latest MapLab code and an Ubuntu 20.04 parent image.

This is used for sandboxing and development. It will:
- Clone the MapLab repo to `./maplab` on the host machine
- During image build, MapLab will be copied to the image and built
- When run `./datasets`, `./maps`, and `./bin` will be mapped the host system to the image
- The display will be mapped to the host systems so RViz can be used
- It will provide a bash prompt by default when started (there is no overridden start command, but feel free to add one)

Feel free to reach out if you're trying it or have any issues.

## Installation

- Pull the repository
- Run `make all` to build the Docker image named `maplab:latest`

## Running the image

- Run `make run` on the host system to start the image

Inside the image:
- Source the workspace: `source /maplab_ws/devel/setup.bash`
- Start ROSCore: `roscore&`
- Run maplab: `rosrun maplab_console maplab_console`
- You can also use some packaged scripts for building maps, which are found in `/bin`, e.g. `rovioli_create_map.sh` for using Rovioli to create a map