#!/bin/bash -l

# Create the conda environment and associated kernel.
#
# Usage:
# source ./install_conda_environment_and_kernel_from_yml.sh conda_choice environment

# conda uses the libmamba solver.
# See conda info user-agent: solver/libmamba
conda_choice=$1
echo "conda_choice: "${conda_choice}
environment=$2
echo "environment: "$environment

echo "which conda: "$(which conda)
echo "which python: "$(which python)

conda_root=/home/ghubhost/anaconda/${conda_choice}

conda_env_yml=./${conda_choice}_${environment}_environment.yml

start1=$(date +%s)
echo "Creating env "${environment}"..."
# -n,--name: Name of the environment
${conda_root}/bin/conda env create --name ${environment} --file ${conda_env_yml}
end=$(date +%s)
echo "Env ${environment} created. Elapsed time: $((($end-$start1)/60)) minutes"

echo "Activating env "${environment}"..."
# Observation, conda activate returns Your shell has not been properly configured to use conda activate and
# conda init bash returns No action taken.
. ${conda_root}/bin/activate ${environment}
echo "Env ${environment} activated"

echo "Installing the kernel for env "${environment}"..."

if [[ ${environment} == "geospatial-2021-09" ]]; then
    if [[ ${conda_choice} == "anaconda-6" ]]; then
        python -m ipykernel install --sys-prefix --name "geospatial-anaconda-6" --display-name "geospatial-plus python3"
        python -m ipykernel install --prefix ${conda_root} --name "geospatial-anaconda-6" --display-name "geospatial-plus python3"
    else
        python -m ipykernel install --sys-prefix --name "geospatial-2021-09" --display-name "geospatial-plus python3"
        python -m ipykernel install --prefix ${conda_root} --name "geospatial-2021-09" --display-name "geospatial-plus python3"
    fi
else
    python -m ipykernel install --sys-prefix --name ${environment} --display-name "Python3 (${environment})"
    python -m ipykernel install --prefix ${conda_root} --name ${environment} --display-name "Python3 (${environment})"
fi

echo "Deactivating env "${environment}"..."
${conda_root}/bin/conda deactivate
echo "Env ${environment} deactivated"

echo "which jupyter: "$(which jupyter)
echo "which python: "$(which python)
echo "jupyter kernelspec list: "$(jupyter kernelspec list)

end=$(date +%s)
echo "Done. Total elapsed time: $((($end-$start1)/60)) minutes"
