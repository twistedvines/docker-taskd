#!/bin/bash

PEM_FILES=(
  server.cert
  server.key
  server.crl
  ca.cert
)

cd /home/taskd/pki
./generate

mkdir -p "${TASKDDATA}/certs/"

for file in ${PEM_FILES[@]}; do
  cp "${file}.pem" "${TASKDDATA}/certs"
  taskd config --force "${file}" "${TASKDDATA}/certs/${file}.pem"
done
