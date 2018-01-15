#!/bin/bash

HOSTNAME="${HOSTNAME:-0.0.0.0}"
PORT="${PORT:-53589}"

/usr/local/bin/create_keys_and_certs

taskd config --force server "${HOSTNAME}:${PORT}"
taskd $@
