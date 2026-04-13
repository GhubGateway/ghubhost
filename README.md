# Ghub Tools

This repository contains Dockerfiles for Ghub tools, replicating the tool execution environments for the tools.

Source code files and scripts tested with Docker 4.17.0 on a 2017 iMac running the Ventura 13.7.8 operating system. 

## Usage

### Build the anaconda-7_base_image docker image

Start the Docker Daemon.

Enter source ./build_anaconda-7_base_image.sh to build the anaconda-7_base_image docker image. 

### Launch a Jupyter Notebook (default)

Enter, source ./launch_<tool_alias_name>.sh or source ./launch_<tool_alias_name>.sh true, to build and run the tool's Jupyter Notebook Docker image. This runs a Jupyter Notebook server.

When the *Jupyter Notebook is running at...* message appears, open a web browser and enter the URL localhost\:8000, enter the password: ghubuser and log in. Log out of the notebook and enter Control-C to stop the server.

### Launch a Jupyter Notebook using JupyterHub Dockerspawner

Enter source ./launch_<tool_alias_name>.sh false to build and run the tool's JupyterHub Dockerspawner Docker image. This runs a single-user Jupyter Hub server using the jupyterhub.auth.DummyAuthenticator for development testing only.

When the *JupyterHub is now running at...*  message appears, open a web browser and enter the URL: localhost\:8000, sign in with username: ghubuser, password is not required. Log out of the notebook and enter Control-C to stop the server.

### gisplot2 tool information
  
The ./containers/gisplot2/jupyterhub_dockerspawner/config/jupyterhub_config.py file contains hardcoded absolute paths. These paths will need to be modified. This tool expects a reference directory in ./containers/gisplot2/input-data folder. This setup is for development testing only. The reference directory is stored on Ghub in the /data/groups/ghub/tools directory.

### Appmode

Jupyter notebooks open in Appmode (https://github.com/oschuett/appmode#) 
by default. Click the Edit App and enter Kernel / Restart & Run All for Edit Mode.

### Tool Execution Environment Notes:

Per the HUBzero Tools Administrators document, Ghub Admins are recommended to run HAPI (HUBzero Apps Program Installers) scripts to download, configure, compile, and install software in the tool execution environment. 

For the Ghub anaconda-7 base environment, the recommended install script is https://github.com/hubzero/hapi/blob/master/scripts/anaconda-7_install_deb10.sh. This install script downloads Anaconda3-2020.11-Linux-x86_64.sh using wget https://help.hubzero.org/app/site/addons/tools/Anaconda3-2020.11-Linux-x86_64.sh. Anaconda3-2020.11-Linux-x86_64.sh installs conda version 4.9.2. Over the years, Ghub Admins have added additional Python packages to the original anaconda-7 base environment. On Ghub, ran a script to get a .yml file for the anaconda-7 base environment, anaconda-7_base_environment.yml. Downloaded a version of Miniconda consistent with Anaconda3-2020.11-Linux-x86_64.sh, from https://repo.anaconda.com/miniconda, Miniconda3-py38_4.9.2-Linux-x86_64.sh. The ./anaconda/Dockerfile.anaconda-7 Dockerfile builds the anaconda-7_base_image Docker image, which is based on the official Debian 10 "buster-slim" Docker image, Miniconda is installed and then updated with Python packages contained in the anaconda-7_base_environment.yml file.

Using JupyterHub 1.5.1. NotebookApp (Legacy): The classic Jupyter Notebook server uses specific routes like /apps/[notebook_name].ipynb for Appmode. When run locally with NotebookApp, these routes work as expected. SingleUserLabApp (JupyterLab/Jupyter Server): In modern JupyterHub deployments (version 2.0 and later), the default single-user server is often based on Jupyter Server and launches JupyterLab, not the legacy NotebookApp. This setup does not inherently recognize the specific /apps/ routing expected by the classic Appmode extension, resulting in a 404 or 500 error.

 
