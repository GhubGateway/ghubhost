#!/bin/bash -l

LAUNCH_JUPYTER_NOTEBOOK=${1:-true}
echo "LAUNCH_JUPYTER_NOTEBOOK: "${LAUNCH_JUPYTER_NOTEBOOK}

source ./remove_jupyterhub_container.sh

# Get the Ghub tool from the tool's repository
(cd ./tools && [ ! -d "icesheet1" ] && source ./get_icesheet1.sh)

[ -n "$(docker images -q icesheet1_tool_image:latest)" ] && docker rmi icesheet1_tool_image:latest
if [ "${LAUNCH_JUPYTER_NOTEBOOK}" = true ]; then
    echo "Launching Jupyter Notebook..."
    docker image build -f ./containers/icesheet1/jupyter_notebook/Dockerfile.icesheet1 -t icesheet1_tool_image:latest . 2>&1 | tee build.log
    docker run --privileged --rm -p 8000:8888 icesheet1_tool_image:latest
else
    echo "Launching JupyterHub DockerSpawner..."
    docker image build -f ./containers/icesheet1/jupyterhub_dockerspawner/Dockerfile.icesheet1 -t icesheet1_tool_image:latest . 2>&1 | tee build.log
    (cd ./containers/icesheet1/jupyterhub_dockerspawner && docker compose up --build)
fi
