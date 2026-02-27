# ghubhost

This repository contains Dockerfiles for Ghub tools, replicating the Ghub anaconda-7 or anaconda-6 execution environments required by the tools. Keeping the Dockerfiles separate for each tool provides the smallest footprint for running the tools' Jupyter notebooks and allows testing each notebook via a web browser. Later, the Docker images can be consolidated as required.


Tested each Dockerfile by building the Docker image, running the Docker container, and opening the tool's Jupyter notebook via a web browser's localhost:9999 URL. Development platform is Docker 4.17.0 on a 2017 iMac running the Ventura 13.7.8 operating system.
 
## Notes

### System Installations Notes:

The system installations are different for each Dockerfile, depending on the underlying non-Python software required for the tool the base anaconda environment required for the tool.

### Anaconda Installations Notes:

Per the HUBzero Tools Administrators document, Ghub Admins are recommended to run HAPI (HUBzero Apps Program Installers) scripts to download, configure, compile, and install software in the tool execution environment. 

For the Ghub anaconda-7 base environment, the recommended install script is https://github.com/hubzero/hapi/blob/master/scripts/anaconda-7_install_deb10.sh. This install script downloads Anaconda3-2020.11-Linux-x86_64.sh using wget https://help.hubzero.org/app/site/addons/tools/Anaconda3-2020.11-Linux-x86_64.sh. Anaconda3-2020.11-Linux-x86_64.sh installs conda version 4.9.2. Over the years, Ghub Admins have added additional Python packages to the original anaconda-7 base environment. On Ghub, ran a script to get a .yml file for the anaconda-7 base environment, anaconda-7_base_environment.yml. Downloaded a version of Miniconda consistent with Anaconda3-2020.11-Linux-x86_64.sh, from https://repo.anaconda.com/miniconda, Miniconda3-py38_4.9.2-Linux-x86_64.sh. The ./ghubhost/anaconda/Dockerfile.anaconda-7 Dockerfile builds the anaconda-7_base_image docker image which is based on the official Debian 10 "buster-slim" docker image, Miniconda is installed and then updated with Python packages contained in the anaconda-7_base_environment.yml file.

For the Ghub anaconda-6 base environment, the recommended script is https://github.com/hubzero/hapi/blob/master/scripts/anaconda-6_install_deb10.sh. This install script downloads Anaconda3-2018.12-Linux-x86_64.sh using wget https://help.hubzero.org/app/site/addons/tools/Anaconda3-2018.12-Linux-x86_64.sh. Anaconda3-2018.12-Linux-x86_64.sh installs conda version 4.5.12. On Ghub, ran a script to get a .yml file for the anaconda-6 base environment anaconda-6_base_environment.yml. For each Dockerfile, Anaconda is installed. conda 4.5.12 is known to have issues that affects conda env update, conda create, and conda install using the conda-forge channel. Additional packages required by each tool are explicitly installed with pip based on the anaconda-6_base_environment.yml file.

Dockerfiles for the tools are based on the anaconda-7_base_image or the anaconda-6_base_image.
For each tool, opened the tool on Ghub to determine if the tool uses an environment different than the base. If so, ran a script on Ghub to get the environment's .yml file, and in this case, the Dockerfile for the tool installs the environment for the tool based on the environment's .yml file. Due to the conda 4.5.1 issues, this did not work as expected for anaconda-6. The issue was fixed in conda 4.6.0, but dependency issues, etc, occurred when updating conda 4.5.1+ with Python packages contained in anaconda-6 geospatial-plus python3 environment .yml file. Ghub anaconda-6 based tools, which require the geospatial-plus python3 environment, were updated to use the anaconda-7 geospatial-plus python3 environment.

Some Jupyter notebooks access data in the Ghub /data/tools and /data/groups/ghub/tools directories. These tools will need to be modified to access mounted directories on the new platform.

### Notebook Configuration Notes:

For each tool, the source code downloaded from the tool's repository is added to the Docker image. Scripts are added to the Docker image, similar in concept to the Ghub tool's middleware/invoke script's call to /usr/bin/invoke_app start_jupyter.

## Usage

The steps below are specific for the alps tool as a template. Also see ./ghubhost/containers/alps/Dockerfile.alps. Perform similar steps for the other tools.

### Download the tool from the tool's repository

Download the alps tool's source code from the alps tool's repository to the ./ghubhost/tools directory. See ./ghubhost/tools/get_alps.sh for information on how to do this. On Ghub, the tool's Wiki page also contains information on how to do this.

### Build the Docker image

cd ./ghubhost<br>
docker image build -f ./containers/alps/Dockerfile.alps -t alps_image . 2>&1 | tee build.log

### Run the Docker image

docker run --privileged --rm -v $PWD/shared-storage:/home/ghubhost/shared-storage -p 9999:8888 alps_image. Wait for the Jupyter Notebook is running at message to appear.

### Open the Jupyter notebook

See the ./ghubhost/tools/alps/middleware/invoke, ./ghubhost/containers/alps/Dockerfile.alps, ./ghubhost/containers/alps/config/start_jupyter.sh, and ./ghubhost/containers/alps/config/supervisord.conf files for more information.

#### [Appmode](https://github.com/oschuett/appmode#)

Open a web browser and enter the URL localhost:9999/apps/alps.ipynb, enter the password ghubhost, and login. 

#### Edit Mode

Open a web browser and enter the URL localhost:9999/notebooks/alps.ipynb, enter the password ghubhost, login, and select Kernel / Restart & Run All.

### Close the Jupyter notebook

Log out of the alps.ipynb Jupyter Notebook and enter Ctrl+C to stop the running Docker container.

 
