#!/bin/bash -l

LAUNCH_JUPYTER_NOTEBOOK=${1:-true}
echo "LAUNCH_JUPYTER_NOTEBOOK: "${LAUNCH_JUPYTER_NOTEBOOK}

source ./remove_jupyterhub_container.sh

# Get the Ghub tool from the tool's repository
(cd ./tools && [ ! -d "gisplot2" ] && source ./get_gisplot2.sh)

(cd ./containers/gisplot2/generated-data && pwd && [ -n "$(ls -A)" ] && rm -f *)
(cd ./containers/gisplot2/input-data &&  pwd && [ ! -d "reference" ] && tar -xvzf reference.tar.gz)

[ -n "$(docker images -q gisplot2_tool_image:latest)" ] && docker rmi gisplot2_tool_image:latest
if [ "${LAUNCH_JUPYTER_NOTEBOOK}" = true ]; then
    echo "Launching Jupyter Notebook..."
    docker image build -f ./containers/gisplot2/jupyter_notebook/Dockerfile.gisplot2 -t gisplot2_tool_image:latest . 2>&1 | tee build.log
    docker run --privileged --rm -v $PWD/containers/gisplot2/input-data:/home/ghubuser/input-data -v $PWD/containers/gisplot2/generated-data:/home/ghubuser/generated-data -p 8000:8888 gisplot2_tool_image:latest
else
    # Note: The ./containers/gisplot2/jupyterhub_dockerspawner/config/jupyterhub_config.py file contains hardcoded absolute paths. These paths will need to be modified.
    echo "Launching JupyterHub DockerSpawner..."
    docker image build -f ./containers/gisplot2/jupyterhub_dockerspawner/Dockerfile.gisplot2 -t gisplot2_tool_image:latest . 2>&1 | tee build.log
    (cd ./containers/gisplot2/jupyterhub_dockerspawner && docker compose up --build)
fi

