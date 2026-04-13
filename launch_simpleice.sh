#!/bin/bash -l

LAUNCH_JUPYTER_NOTEBOOK=${1:-true}
echo "LAUNCH_JUPYTER_NOTEBOOK: "${LAUNCH_JUPYTER_NOTEBOOK}

source ./remove_jupyterhub_container.sh

# Get the Ghub tool from the tool's repository
(cd ./tools && [ ! -d "simpleice" ] && source ./get_simpleice.sh)

[ -n "$(docker images -q simpleice_tool_image:latest)" ] && docker rmi simpleice_tool_image:latest
if [ "${LAUNCH_JUPYTER_NOTEBOOK}" = true ]; then
    echo "Launching Jupyter Notebook..."
    docker image build -f ./containers/simpleice/jupyter_notebook/Dockerfile.simpleice -t simpleice_tool_image:latest . 2>&1 | tee build.log
    docker run --privileged --rm -p 8000:8888 simpleice_tool_image:latest
else
    echo "Launching JupyterHub DockerSpawner..."
    docker image build -f ./containers/simpleice/jupyterhub_dockerspawner/Dockerfile.simpleice -t simpleice_tool_image:latest . 2>&1 | tee build.log
    (cd ./containers/simpleice/jupyterhub_dockerspawner && docker compose up --build)
fi
