#!/bin/bash
set -euo pipefail

# copy service file and customize it
ln -s /root/cosmos-discord-faucet/discord-faucet-bot.service /etc/systemd/system/

systemctl enable discord-faucet-bot
systemctl start discord-faucet-bot