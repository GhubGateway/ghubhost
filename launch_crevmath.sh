#!/bin/bash -l

LAUNCH_JUPYTER_NOTEBOOK=${1:-true}
echo "LAUNCH_JUPYTER_NOTEBOOK: "${LAUNCH_JUPYTER_NOTEBOOK}

source ./remove_jupyterhub_container.sh

# Get the Ghub tool from the tool's repository
(cd ./tools && [ ! -d "crevmath" ] && source ./get_crevmath.sh)

[ -n "$(docker images -q crevmath_tool_image:latest)" ] && docker rmi crevmath_tool_image:latest
if [ "${LAUNCH_JUPYTER_NOTEBOOK}" = true ]; then
    echo "Launching Jupyter Notebook..."
    docker image build -f ./containers/crevmath/jupyter_notebook/Dockerfile.crevmath -t crevmath_tool_image:latest . 2>&1 | tee build.log
    docker run --privileged --rm -p 8000:8888 crevmath_tool_image:latest
else
    echo "Launching JupyterHub DockerSpawner..."
    docker image build -f ./containers/crevmath/jupyterhub_dockerspawner/Dockerfile.crevmath -t crevmath_tool_image:latest . 2>&1 | tee build.log
    (cd ./containers/crevmath/jupyterhub_dockerspawner && docker compose up --build)
fi

