#!/bin/bash -l

source ./remove_jupyterhub_container.sh

docker rmi anaconda-7_base_image:latest -f

# Needs Docker memory set to 8GB
docker image build -f ./anaconda/Dockerfile.anaconda-7 -t anaconda-7_base_image . 2>&1 | tee build.log

