# Discord Faucet Bot

This folder contains setup scripts for [cosmos-discord-faucet](https://github.com/CosmWasm/cosmos-discord-faucet)

First, copy all files from this directory to the machine:

`scp -r ./* root@1.2.3.4:`

Also, copy the proper env for the testnet you choose:

`scp ../../oysternet-1/defaults.env root@1.2.3.4:`

## Get Discord Token

Follow the steps in [tutorial](https://www.writebots.com/discord-bot-token/#:~:text=Discord%20Bot%20Token%3F-,A%20Discord%20Bot%20Token%20is%20a%20short%20phrase%20(represented%20as,in%20turn%20controls%20bot%20actions.)

Bot must have these permissions: 
 - View Channels 
 - Send Messages 
 - Read Message History 

**Bot must be a private bot**

## Installing

First, source all the defaults: `source defaults.env`

Then you may want to set the following variables locally:

* `MNEMONIC` - Faucet mnemonic
* `GAS_PRICE` - Gas price in decimals (optional, default 10000 or 0.01ufee)
* `DENOM_LIST` - List of tokens faucet will tap (optional, default if defined in defaults.env "STAKE_DENOM,FEE_DENOM")
* `SEND_AMOUNT` - Token decimcal amount to send separated by comma, order follows DENOM_LIST (optional, default "5000000,50000000")
* `BECH32_HRP` - Bech32 prefix (optional, default "wasm")
* `DISCORD_TOKEN` - Discord token for reading and sending messages
* `DISCORD_CHANNEL` - Discord channel listen to 
* `EXPLORER_URL` - Block explorer URL (optional, leave blank)
* `CONFIG_FILE` - Location of config file (optional, "/root/cosmos-discord-faucet/config.ini")

Then run it like: `./install.sh`

The script must be run as root. If you are not logged in as root, try `sudo -E install.sh`

## Running

Run `./services.sh` to start the bot.

## Using

