#!/bin/bash

# set up the jupyter notebook
if [ "x$NOTEBOOK_PASSWORD" = "x" ]; then
    NOTEBOOK_PASSWORD="ghubhost"
fi
if [ "x$NOTEBOOK_BASE_URL" = "x" ]; then
    NOTEBOOK_BASE_URL="/"
fi
ENCPASSWORD=$(python3 -c "from notebook.auth import passwd;print(passwd(\"$NOTEBOOK_PASSWORD\"))")
mkdir -p /home/ghubhost/.jupyter
cat >/home/ghubhost/.jupyter/jupyter_notebook_config.json <<EOF
{ "NotebookApp":
   { 
      "base_url": "$NOTEBOOK_BASE_URL",
      "password": "$ENCPASSWORD"
   }
}
EOF
chown -R ghubhost: /home/ghubhost/.jupyter
cat /home/ghubhost/.jupyter/jupyter_notebook_config.json

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

