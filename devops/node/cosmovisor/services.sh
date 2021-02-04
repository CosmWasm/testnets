#!/bin/bash
set -euo pipefail

# set all variables
WASMD_HOME="${WASMD_HOME:-/root/.wasmd}"
COSMOVISOR_BINARY_DIR=${COSMOVISOR_BINARY_DIR:-/usr/local/bin}

TARGET="/etc/systemd/system/cosmovisor.service"

# copy service file and customize it
mv ./cosmovisor.service "${TARGET}"
# use , as separator, as $DOCKER and $WASMD_HOME use / internally
sed -i "s,WASMD_HOME,$WASMD_HOME,g" "${TARGET}"
sed -i "s,COSMOVISOR_BINARY_DIR,$COSMOVISOR_BINARY_DIR,g" "${TARGET}"

systemctl enable cosmovisor.service
systemctl start cosmovisor.service
