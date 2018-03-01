# openFrameworks 0.8.4

openFrameworks 0.8.4 with qt-creator over Ubuntu 14.04

Docker should be called with

`docker run --device /dev/nvidia0 --device /dev/nvidiactl -e DISPLAY=$DISPLAY -v /tmp:/tmp --name=some_name_that_you_want -v ~/Documents/EggPattern:/root/EggPattern -it thtung1/openframeworks0.8.4`
