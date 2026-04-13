#!/bin/bash -l

LAUNCH_JUPYTER_NOTEBOOK=${1:-true}
echo "LAUNCH_JUPYTER_NOTEBOOK: "${LAUNCH_JUPYTER_NOTEBOOK}

source ./remove_jupyterhub_container.sh

# Get the Ghub tool from the tool's repository
(cd ./tools && [ ! -d "moulins1" ] && source ./get_moulins1.sh)

[ -n "$(docker images -q moulins1_tool_image:latest)" ] && docker rmi moulins1_tool_image:latest
if [ "${LAUNCH_JUPYTER_NOTEBOOK}" = true ]; then
    echo "Launching Jupyter Notebook..."
    docker image build -f ./containers/moulins1/jupyter_notebook/Dockerfile.moulins1 -t moulins1_tool_image:latest . 2>&1 | tee build.log
    docker run --privileged --rm -p 8000:8888 moulins1_tool_image:latest
else
    echo "Launching JupyterHub DockerSpawner..."
    docker image build -f ./containers/moulins1/jupyterhub_dockerspawner/Dockerfile.moulins1 -t moulins1_tool_image:latest . 2>&1 | tee build.log
    (cd ./containers/moulins1/jupyterhub_dockerspawner && docker compose up --build)
fi
