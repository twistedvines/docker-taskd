#!/bin/bash

ORG="$1"
USER="$2"

taskd add user "$ORG" "$USER"
cd /home/taskd/pki
if ! [ -f "${HOME}/pki/$USER.cert.pem" ]; then
  ./generate.client "$USER"
else
  echo "client certificate already exists: skipping"
fi
