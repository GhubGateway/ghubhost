#!/bin/bash

# set up the jupyter notebook
if [ "x$NOTEBOOK_PASSWORD" = "x" ]; then
    NOTEBOOK_PASSWORD="ghubuser"
fi
if [ "x$NOTEBOOK_BASE_URL" = "x" ]; then
    NOTEBOOK_BASE_URL="/"
fi
ENCPASSWORD=$(python3 -c "from notebook.auth import passwd;print(passwd(\"$NOTEBOOK_PASSWORD\"))")
mkdir -p /home/ghubuser/.jupyter
cat >/home/ghubuser/.jupyter/jupyter_notebook_config.json <<EOF
{ "NotebookApp":
   { 
      "base_url": "$NOTEBOOK_BASE_URL",
      "password": "$ENCPASSWORD",
      "default_url": "/apps/simpleice.ipynb"
   }
}
EOF
chown -R ghubuser: /home/ghubuser/.jupyter
cat /home/ghubuser/.jupyter/jupyter_notebook_config.json

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

