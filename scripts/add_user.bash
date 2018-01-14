#!/bin/bash

ORG="$1"
USER="$2"

taskd add user "$ORG" "$USER"
cd /home/taskd/pki
./generate.client "$USER"
