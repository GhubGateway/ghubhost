#!/bin/bash -l

LAUNCH_JUPYTER_NOTEBOOK=${1:-true}
echo "LAUNCH_JUPYTER_NOTEBOOK: "${LAUNCH_JUPYTER_NOTEBOOK}

source ./remove_jupyterhub_container.sh

# Get the Ghub tool from the tool's repository
(cd ./tools && [ ! -d "ismip6aissvn" ] && source ./get_ismip6aissvn.sh)

[ -n "$(docker images -q ismip6aissvn_tool_image:latest)" ] && docker rmi ismip6aissvn_tool_image:latest
if [ "${LAUNCH_JUPYTER_NOTEBOOK}" = true ]; then
    echo "Launching Jupyter Notebook..."
    docker image build -f ./containers/ismip6aissvn/jupyter_notebook/Dockerfile.ismip6aissvn -t ismip6aissvn_tool_image:latest . 2>&1 | tee build.log
    docker run --privileged --rm -p 8000:8888 ismip6aissvn_tool_image:latest
else
    echo "Launching JupyterHub DockerSpawner..."
    docker image build -f ./containers/ismip6aissvn/jupyterhub_dockerspawner/Dockerfile.ismip6aissvn -t ismip6aissvn_tool_image:latest . 2>&1 | tee build.log
    (cd ./containers/ismip6aissvn/jupyterhub_dockerspawner && docker compose up --build)
fi
