#!/bin/bash -l

# Usage:
# source ./create_conda_environment_yml.sh conda_choice environment
conda_choice=$1
echo "conda_choice: "${conda_choice}
environment=$2
echo "environment: "$environment

# -e: Environment only.  Act on the current shell.  Do not preserve.
# -r: Replace an already selected version without prompting.
. /etc/environ.sh
use -e -r ${conda_choice}
echo "which conda: "$(which conda)
echo "which python: "$(which python)

conda_env_yml=./${conda_choice}_${environment}_environment.yml

start1=$(date +%s)

source activate ${environment}
echo "which python: "$(which python)
rm -rf ${conda_env_yml}
conda env export | grep -v "^name: " | grep -v "^prefix: " > ${conda_env_yml}
conda deactivate

end=$(date +%s)
echo "Done. Total elapsed time: $(($end-$start1)) seconds"
