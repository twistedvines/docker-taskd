#!/bin/bash

PEM_FILES=(
  server.cert
  server.key
  server.crl
  ca.cert
)

cd /usr/local/src/taskd/pki
./generate

for file in ${PEM_FILES[@]}; do
  cp "${file}.pem" "${TASKDDATA}"
  taskd config --force "${file}" "${TASKDDATA}/${file}.pem"
done
