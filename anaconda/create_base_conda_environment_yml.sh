#!/bin/bash -l

# Usage:
# source ./create_base_conda_environment_yml.sh conda_choice

conda_choice=$1
echo "conda_choice: "${conda_choice}

# -e: Environment only.  Act on the current shell.  Do not preserve.
# -r: Replace an already selected version without prompting.
. /etc/environ.sh
use -e -r ${conda_choice}
echo "which conda: "$(which conda)

conda_env_yml=./${conda_choice}_base_environment.yml

echo "Creating "${conda_env_yml}"..."

start1=$(date +%s)

source activate base
rm -rf ${conda_env_yml}
conda env export | grep -v "^name: " | grep -v "^prefix: " > ${conda_env_yml}
conda deactivate

end=$(date +%s)
echo "Done. Total elasped time: $(($end-$start1)) seconds"

