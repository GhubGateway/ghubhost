#!/bin/bash -l

LAUNCH_JUPYTER_NOTEBOOK=${1:-true}
echo "LAUNCH_JUPYTER_NOTEBOOK: "${LAUNCH_JUPYTER_NOTEBOOK}

source ./remove_jupyterhub_container.sh

# Get the Ghub tool from the tool's repository
(cd ./tools && [ ! -d "ALPS2" ] && source ./get_alps2.sh)

[ -n "$(docker images -q alps2_tool_image:latest)" ] && docker rmi alps2_tool_image:latest
if [ "${LAUNCH_JUPYTER_NOTEBOOK}" = true ]; then
    echo "Launching Jupyter Notebook..."
    docker image build -f ./containers/alps2/jupyter_notebook/Dockerfile.alps2 -t alps2_tool_image:latest . 2>&1 | tee build.log
    docker run --privileged --rm -p 8000:8888 alps2_tool_image:latest
else
    echo "Launching JupyterHub DockerSpawner..."
    docker image build -f ./containers/alps2/jupyterhub_dockerspawner/Dockerfile.alps2 -t alps2_tool_image:latest . 2>&1 | tee build.log
    (cd ./containers/alps2/jupyterhub_dockerspawner && docker compose up --build)
fi
