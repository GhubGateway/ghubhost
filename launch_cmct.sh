#!/bin/bash -l

LAUNCH_JUPYTER_NOTEBOOK=${1:-true}
echo "LAUNCH_JUPYTER_NOTEBOOK: "${LAUNCH_JUPYTER_NOTEBOOK}

source ./remove_jupyterhub_container.sh

# Get the Ghub tool from the tool's repository
(cd ./tools && [ ! -d "CmCt" ] && source ./get_cmct.sh)

[ -n "$(docker images -q cmct_tool_image:latest)" ] && docker rmi cmct_tool_image:latest
if [ "${LAUNCH_JUPYTER_NOTEBOOK}" = true ]; then
    echo "Launching Jupyter Notebook..."
    docker image build -f ./containers/cmct/jupyter_notebook/Dockerfile.cmct -t cmct_tool_image:latest . 2>&1 | tee build.log
    docker run --privileged --rm -p 8000:8888 cmct_tool_image:latest
else
    echo "Launching JupyterHub DockerSpawner..."
    docker image build -f ./containers/cmct/jupyterhub_dockerspawner/Dockerfile.cmct -t cmct_tool_image:latest . 2>&1 | tee build.log
    (cd ./containers/cmct/jupyterhub_dockerspawner && docker compose up --build)
fi
