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
      "default_url": "/apps/icesheet1.ipynb",
      "iopub_data_rate_limit": 10000000000,
      "iopub_msg_rate_limit": 1000000,
      "rate_limit_window": 10,
      "tornado_settings": {
          "websocket_max_message_size": 419430400,
          "max_buffer_size": 419430400,
          "max_body_size": 419430400
      }
   }
}
EOF
chown -R ghubuser: /home/ghubuser/.jupyter
cat /home/ghubuser/.jupyter/jupyter_notebook_config.json

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf

