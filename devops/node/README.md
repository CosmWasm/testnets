# Set up a Full Node

These instructions work for a machine running Ubuntu 20.04. 

Optimal Requirements: 2 CPU, 4 GB RAM, 40 GB SSD.

First, copy all files from this directory to the machine:

`scp -r ./* root@1.2.3.4:`

Also, copy the proper env for the testnet you choose:

`scp ../../oysternet-1/defaults.env root@1.2.3.4:`

## Installing

First, source all the defaults: `source defaults.env`

Then you may want to set the following variables locally:

* `MONIKER` - this is the moniker you use for the node. it should be unique and descriptive (required)
* `WASMD_HOME` - this is the directory where all the data is stored. Default `/root`
* `REPOSITORY` - the docker image repository to use. Default `cosmwasm/wasmd` (maybe you have a fork?)

Then run it like: `MONIKER=my-name-here ./install.sh`

The script must be run as root. If you are not logged in as root, try `sudo -E install.sh`

Running this will set up all dependencies, create a local wasmd config for the proper testnet and will run node in docker container.

## Configuring

You will want to set up some nodes to connect to. The simplest (and restart safest) way to do so
is to edit `config/config.toml` in your chain-specific config dir.

You will want to set one or more of the following, all under `[p2p]`:

* `seeds` - a seed node to connect to for other peers
* `persistent_peers` - a peer to connect with everytime we restart
* `private_peers` - node_ids from above nodes that we do not want to gossip

You can use `$SEED_NODE` (from `defaults.env`) as either a seed (preferred) or a persistent peer
in order to get attached. These all look like `${node_id}@${ip}:${port}`. Node_id is a hash of the
public key, so you can recognize the same machine if it moves ips.

To get the `node_id` of your current node, run `./node_id.sh`

Remember to allow or disallow rpc endpoints for sentry and validators.

## Systemd

If you wish to run this under systemd, then run `services.sh` to set up a default config to auto-restart the node.
This will install a service file with the binary name under eg `/etc/systemd/system/wasmd.service`,
enable it to start on reboot, and then start it running.

You may also run this manually or use another supervisor and skip this step.

## Docker container

If you are following instructions from this page you should run commands directly from docker container. In this case you will need to use `docker exec -it wasmd wasmd` instead of `wasmd` command.

## Staking

Once your node has caught up, if you want to become a validator, just delegate some funds to it.

First, make sure you can connect to it and control an account with some funds.
Example for musselnet, values taken from `defaults.env`, `validator` being your local name for a key with funds behind it:

```bash
wasmd config chain-id musselnet
wasmd config node http://rpc.oysternet.cosmwasm.com:80

wasmd query account $(wasmd keys show -a validator)
```

And get your pubkey from the validator machine:

```
root@validator$ ./show_validator.sh
# copy this as VAL_PUBKEY in your local shell
```

Then see [testnet instructions](https://docs.cosmwasm.com/testnets/testnets.html) or just run a command like:

```bash
wasmd tx staking create-validator \
  --amount="100000000ufrites" \
  --pubkey=${VAL_PUBKEY} \
  --moniker=$MONIKER \
  --chain-id=oysternet-1 \
  --commission-rate="0.10" \
  --commission-max-rate="0.20" \
  --commission-max-change-rate="0.01" \
  --min-self-delegation="1" \
  --gas="400000" \
  --fees="5000umayo" \
  --from=validator
```
