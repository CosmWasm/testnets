#!/bin/bash
set -euo pipefail

SERVICE=faucet
TARGET="/etc/systemd/system/${SERVICE}.service"

if [ -z "$FAUCET_MNEMONIC" ]; then 
    echo "You must export FAUCET_MNEMONIC to properly set up the faucet"
    exit 1
fi

# copy service file and customize it
# TODO: allow to customize the tokens you get
mv ./faucet.service "${TARGET}"
sed -i "s/TOP_SECRET_MNEMONIC/$FAUCET_MNEMONIC/g" "${TARGET}"

systemctl enable "${SERVICE}"
systemctl start "${SERVICE}"
