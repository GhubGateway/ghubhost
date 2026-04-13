#!/bin/bash -l

echo "Removing containers and cleaning the container cache..."
docker stop jupyterhub
docker rm jupyterhub
docker container prune -f

echo "Removing volumes and cleaning the volume cache......"
docker volume rm jupyterhub-user-ghubuser -f
docker volume prune -f

echo "Removing images and cleaning the image cache......"
docker images --format "{{.Repository}}:{{.Tag}}" | grep "dockerspawner-jupyterhub" | xargs -r docker rmi -f
docker images --format "{{.Repository}}:{{.Tag}}" | grep "tool_image" | xargs -r docker rmi -f
docker image prune -f

echo "Cleaning the build cache..."
docker builder prune -f

