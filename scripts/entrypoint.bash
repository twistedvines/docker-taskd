#!/bin/bash

HOSTNAME="${HOSTNAME:-0.0.0.0}"
PORT="${PORT:-53589}"

taskd config --force server "${HOSTNAME}:${PORT}"
taskd server --data "${TASKDDATA}"
