maplab_gitfolder = maplab

$(maplab_gitfolder):
	git clone git@github.com:ethz-asl/maplab.git --recursive

all: | $(maplab_gitfolder)
	cd maplab && git pull
	docker build . -t maplab

run:
	docker run -it \
	--env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--device=/dev/dri:/dev/dri \
	-v ./datasets:/maplab/datasets \
	-v ./maps:/maplab/maps \
	-v ./bin:/maplab/bin \
	maplab:latest

.PHONY: all