
# config/jupyterhub_config.py
import os

# --- Spawner Configuration ---
# Use DockerSpawner to create a container for each user.
# DockerSpawner is a specific implementation that inherits from the abstract Spawner class
c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'

# The Docker image each user gets
c.DockerSpawner.image =  'moulins1_tool_image:latest'

# Connect containers to the JupyterHub network
c.DockerSpawner.network_name = 'jupyterhub-network'

# Mount a persistent volume for each user's work
notebook_dir = '/home/{username}/moulins1'
c.DockerSpawner.notebook_dir = notebook_dir
c.DockerSpawner.volumes = {
    'jupyterhub-user-{username}': notebook_dir,
}

# Appmode (https://github.com/oschuett/appmode):
c.DockerSpawner.args = ['--NotebookApp.default_url=/apps/moulins1.ipynb']
# Edit mode: 
# c.DockerSpawner.args = ['--NotebookApp.default_url=/notebooks/moulins1.ipynb']

# Remove containers when users stop their servers
c.DockerSpawner.remove = True

# Set resource limits per user
#c.DockerSpawner.mem_limit = '2G'
#c.DockerSpawner.cpu_limit = 1.0

# --- Hub Configuration ---
# The Hub must be accessible from the spawned containers
c.JupyterHub.hub_ip = '127.0.0.1'
c.JupyterHub.hub_connect_ip = 'jupyterhub'

# --- Authentication ---
# Use jupyterhub.auth.DummyAuthenticator for initial testing only
c.JupyterHub.authenticator_class = 'jupyterhub.auth.DummyAuthenticator'
# Use native authenticator for simple username/password auth
#c.JupyterHub.authenticator_class = 'nativeauthenticator.NativeAuthenticator'
#c.NativeAuthenticator.minimum_password_length = 8
#c.NativeAuthenticator.open_signup = False

# Admin users who can manage the hub
c.Authenticator.admin_users = {'admin'}

# --- Proxy Configuration ---
c.ConfigurableHTTPProxy.should_start = True

# --- Misc Settings ---
c.JupyterHub.cleanup_servers = True
c.JupyterHub.shutdown_on_logout = False
