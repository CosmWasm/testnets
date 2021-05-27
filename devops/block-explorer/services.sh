#!/bin/bash
set -euo pipefail

SERVICE=block-explorer
TARGET="/etc/systemd/system/${SERVICE}.service"

# copy service file and customize it
mv ./block-explorer.service "${TARGET}"

systemctl enable "${SERVICE}"
systemctl start "${SERVICE}"