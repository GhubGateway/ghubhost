#!/bin/bash -l

LAUNCH_JUPYTER_NOTEBOOK=${1:-true}
echo "LAUNCH_JUPYTER_NOTEBOOK: "${LAUNCH_JUPYTER_NOTEBOOK}

source ./remove_jupyterhub_container.sh

# Get the Ghub tool from the tool's repository
(cd ./tools && [ ! -d "Intro2Python" ] && source ./get_intro2python.sh)

[ -n "$(docker images -q intro2python_tool_image:latest)" ] && docker rmi intro2python_tool_image:latest
if [ "${LAUNCH_JUPYTER_NOTEBOOK}" = true ]; then
    echo "Launching Jupyter Notebook..."
    docker image build -f ./containers/intro2python/jupyter_notebook/Dockerfile.intro2python -t intro2python_tool_image:latest . 2>&1 | tee build.log
    docker run --privileged --rm -p 8000:8888 intro2python_tool_image:latest
else
    echo "Launching JupyterHub DockerSpawner..."
    docker image build -f ./containers/intro2python/jupyterhub_dockerspawner/Dockerfile.intro2python -t intro2python_tool_image:latest . 2>&1 | tee build.log
    (cd ./containers/intro2python/jupyterhub_dockerspawner && docker compose up --build)
fi
