#!/bin/bash

get_opts() {
  while getopts 'r' opt; do
    case "$opt" in
      r)
        FORCE_REGENERATE=true
        ;;
    esac
  done
}

get_opts $@

if [ -f "${HOME}/pki/server.cert.pem" ]; then
  if [ -z "$FORCE_REGENERATE" ]; then
    echo "Certs already generated: use '-r' to force regen"
    exit 0
  else
    rm -f "${HOME}/pki/*.pem"
  fi
fi

PEM_FILES=(
  server.cert
  server.key
  server.crl
  ca.cert
)

result="$(cd /home/taskd/pki && ./generate)"

mkdir -p "${TASKDDATA}/certs/"

for file in ${PEM_FILES[@]}; do
  taskd config --force "${file}" "${HOME}/pki/$file.pem"
done
