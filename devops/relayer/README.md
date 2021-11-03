# Relayer Setup

These instructions work for a machine running Ubuntu 20.04.

First, copy all files from this directory to the machine:

`scp -r ./* root@1.2.3.4:/root`

Also, copy the proper relayer configurations for the testnet you choose:

`scp -r ../../musselnet/relayer root@1.2.3.4:/root/configs/`

## Installing

* `REPOSITORY` - the docker image repository to use. Default `cosmwasm/relayer` (maybe you have a fork?)
* `RELAYER_HOME` - this is the directory where all the data and configurations is stored. Default `/root`
* `RELAYER_VERSION` - **REQUIRED** the tag of the docker image that will be run, default `latest`
* `CONFIG_DIR` - this is the directory where the initial configuration for relayer is, make sure you copied it from
  testnets repo like above, default `/root/configs`

Then run it like: `./install.sh`

The script must be run as root. If you are not logged in as root, try `sudo -E install.sh`

Running this will set up all dependencies, 

## Adding config file

For easy setup you can import a config file like in [this](../../archive/musselnet/relayer).

* `CONFIG_DIR` - config's directory on server. **REQUIRED**

Then run it like: `./add_config.sh`

## Setting up keys

Either you can setup keys locally then move `~/.relayer/keys` to server to the relayer config filder you chosen
or generate on server using `./generate_key.sh <chain-id> <key-name>` script.

Then with using `./show_address.sh <chain-id> <key-name>` you can see the address of the key, then send some tokens 
to fuel the relayer.

## Initiate light clients

Relayer needs light clients setup before starting listening. 
Initiate the light clients using `./init_light_clients.sh <chain-id>`

## Link path

If the client, connection and path between two chains is not set up before, run `./link_path.sh`.
use it as: `./link_path.sh <path-name>`

## Systemd

If you wish to run this under systemd, then run `services.sh` to set up a default config to auto-restart the relayer.
This will install a service file with the binary name under eg `/etc/systemd/system/relayer.service`,
enable it to start on reboot, and then start it running.

* `PATH_NAME` - **REQUIRED** name of the path is relayer going to listen to.

You may also run this manually or use another supervisor and skip this step.
