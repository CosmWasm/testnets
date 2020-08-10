#!/bin/bash
set -euo pipefail

# set all variables
REPOSITORY=${REPOSITORY:-cosmwasm/wasmd}
DOCKER="$REPOSITORY:$WASMD_VERSION"
WASMD_HOME="${WASMD_HOME:-/root}"

TARGET="/etc/systemd/system/${BINARY}.service"

# copy service file and customize it
mv ./wasmd.service "${TARGET}"
sed -i "s/BINARY/$BINARY/g" "${TARGET}"
# use , as separator, as $DOCKER and $WASMD_HOME use / internally
sed -i "s,DOCKER,$DOCKER,g" "${TARGET}"
sed -i "s,WASMD_HOME,$WASMD_HOME,g" "${TARGET}"

systemctl enable "${BINARY}"
systemctl start "${BINARY}"