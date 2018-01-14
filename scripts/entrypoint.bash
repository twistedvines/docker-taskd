#!/bin/bash

HOSTNAME="${HOSTNAME:-0.0.0.0}"
PORT="${PORT:-53589}"

cp -f "${TASKDDATA}/certs/*" /home/taskd/pki

taskd config --force server "${HOSTNAME}:${PORT}"
taskd $@
