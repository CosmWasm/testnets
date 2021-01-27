#!/bin/bash
set -euo pipefail

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/relayer}
RELAYER_VERSION=${RELAYER_VERSION}
DOCKER="$REPOSITORY:$RELAYER_VERSION"
RELAYER_HOME="${RELAYER_HOME:-/root/.relayer}"

TARGET="/etc/systemd/system/relayer.service"

# copy service file and customize it
mv ./relayer.service "${TARGET}"
sed -i "s,PATH_NAME,$PATH_NAME,g" "${TARGET}"
sed -i "s,DOCKER,$DOCKER,g" "${TARGET}"
sed -i "s,RELAYER_HOME,$RELAYER_HOME,g" "${TARGET}"

systemctl enable relayer.service
systemctl start relayer.service
