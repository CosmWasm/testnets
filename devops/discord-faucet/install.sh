#!/bin/bash
set -euo pipefail

if [ -z "$CHAIN_ID" ]; then
    echo You must set chain id
    exit 1
fi

if [ -z "$MNEMONIC" ]; then
    echo You must set faucet mnemonic
    exit 1
fi

if [ -z "$FAUCET_ADDR" ]; then
    echo You must set faucet address
    exit 1
fi

if [ -z "$DISCORD_TOKEN" ]; then
    echo You must set discord access token
    exit 1
fi

if [ -z "$DISCORD_CHANNEL" ]; then
    echo You must set discord channel
    exit 1
fi

if [ -z "$FEE_DENOM" ]; then
    echo You must set FEE_DENOM
    exit 1
fi

if [ -z "$RPC" ]; then
    echo You must set rpc endpoint
    exit 1
fi

if [ -z "$LCD" ]; then
    echo You must set lcd endpoint
    exit 1
fi

if [ -z "$DENOM_LIST" ]; then
    echo You must set denom list
    exit 1
fi

# set all variables
GAS_PRICE=${GAS_PRICE:-10000}
SEND_AMOUNT=${SEND_AMOUNT:-"30000,300000"}
EXPLORER_URL=${EXPLORER_URL:-""}
CONFIG_FILE=${CONFIG_FILE:-/root/cosmos-discord-faucet/config.ini}
BECH32_HRP=${BECH32_HRP:-wasm}

apt update \
&& apt install -y python3-pip python3-venv git \
&& cd /root \
&& git clone https://github.com/CosmWasm/cosmos-discord-faucet.git \
&& cd cosmos-discord-faucet \
&& python3 -m venv venv \
&& source venv/bin/activate \
&& pip3 install -r requirements.txt

sed -i "s,LCD,$LCD,g" "${CONFIG_FILE}"
sed -i "s,RPC_URL,$RPC,g" "${CONFIG_FILE}"
sed -i "s/CHAIN_ID/$CHAIN_ID/g" "${CONFIG_FILE}"
sed -i "s/FEE_DENOM/$FEE_DENOM/g" "${CONFIG_FILE}"
sed -i "s/BECH32_HRP_PREFIX/$BECH32_HRP/g" "${CONFIG_FILE}"
sed -i "s/GAS_PRICE/$GAS_PRICE/g" "${CONFIG_FILE}"
sed -i "s/SEND_AMOUNT/$SEND_AMOUNT/g" "${CONFIG_FILE}"
sed -i "s/DENOM_LIST/$DENOM_LIST/g" "${CONFIG_FILE}"
sed -i "s/DISCORD_TOKEN/$DISCORD_TOKEN/g" "${CONFIG_FILE}"
sed -i "s/DISCORD_CHANNEL/$DISCORD_CHANNEL/g" "${CONFIG_FILE}"
sed -i "s/MNEMONIC/$MNEMONIC/g" "${CONFIG_FILE}"
sed -i "s/FAUCET_ADDR/$FAUCET_ADDR/g" "${CONFIG_FILE}"
sed -i "s,EXPLORER_URL,$EXPLORER_URL,g" "${CONFIG_FILE}"




