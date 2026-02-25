#!/bin/bash

# set up the jupyter notebook
if [ "x$NOTEBOOK_PASSWORD" = "x" ]; then
    NOTEBOOK_PASSWORD="ghubhost"
fi
if [ "x$NOTEBOOK_BASE_URL" = "x" ]; then
    NOTEBOOK_BASE_URL="/"
fi
ENCPASSWORD=$(python3 -c "from notebook.auth import passwd;print(passwd(\"$NOTEBOOK_PASSWORD\"))")
# Users upload AIS and/or GIS .nc files for the CmCt tool,
# increase the websocket_max_message_size from the default of 10MiB to 100MiB
mkdir -p /home/ghubhost/.jupyter
cat >/home/ghubhost/.jupyter/jupyter_notebook_config.json <<EOF
{ "NotebookApp":
   { 
      "base_url": "$NOTEBOOK_BASE_URL",
      "password": "$ENCPASSWORD",
      "tornado_settings": {
          "websocket_max_message_size": 104857600
      }
   }
}
EOF
chown -R ghubhost: /home/ghubhost/.jupyter
cat /home/ghubhost/.jupyter/jupyter_notebook_config.json

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

