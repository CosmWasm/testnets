#!/bin/bash
set -euo pipefail

SERVICE=big-dipper
TARGET="/etc/systemd/system/${SERVICE}.service"

# copy service file and customize it
mv ./big-dipper.service "${TARGET}"

systemctl enable "${SERVICE}"
systemctl start "${SERVICE}"