# Dev Ops

This contains some sample scripts that you can use to quickly pull up a node for a testnet.
They are designed for ease of use and simplicity rather than complexity. This is just bash scripts,
designed for Ubuntu, so they should be easy to port to any other system.

Some changes you may wish to make if you deploy this on a value-bearing network:

* Use native binaries rather than docker
* Activate a firewall
* Use hardware key signer
* Further tune the node's config.toml
* Further OS-level security updates

However, for early testnets this should be enough to get started.

## Testnet Launch Check List and Instructions

Here are the check list for new testnet launch. 
You can copy paste this section to new testnet folder to check you follow the steps correctly.

All scripts rely heavily on environment variables to work correctly.
You will want to `source ../<testnetname>/defaults.env` as a basis, then
possibly declare a few more variables as desired.

### Genesis Configuration

- [ ] Checkout to a new branch
- [ ] Duplicate latest network directory and rename it to `newnet`
- [ ] Clean genesis account and gentx in genesis file
- [ ] Update chain-id
- [ ] Update start time in genesis file
- [ ] Update taking and fee token
- [ ] Update replace bech32 addresses
- [ ] Create a reserve address and add it to genesis, Make sure reserve has enough stake and fee tokens
- [ ] Merge the branch to master

### Full Node

#### Validator

- [ ] Spin a new server, Hetzner CX21 is sufficient
- [ ] Clone https://github.com/CosmWasm/testnets
- [ ] Follow [node instructions](node/README.md), make sure you set `FULL_NODE` variable for fullnode setup
- [ ] Copy output of `node_id.sh` this will give you the node id to use in sentry set up
- [ ] Merge the changes to the genesis to testnets repo

#### Sentry

- [ ] Spin a new server, Hetzner CX21 is sufficient
- [ ] Clone https://github.com/CosmWasm/testnets
- [ ] Follow [node instructions](node/README.md), make sure you unset `FULL_NODE` variable for sentry setup.
- [ ] Setup [Public Endpoints](./endpoints): ssl certs and nginx config to serve rpc and lcd endpoints over https. 
- [ ] Make sure RPC endpoint is working
- [ ] Update `SEED_NODE` in newnet/defaults.env
- [ ] Merge the changes to the genesis to testnets repo
 
#### Faucet

[Faucet](./faucet) - Also, you can optionally set up a faucet. However, you need to feed it with tokens
so it has something to give out.

#### Block Explorer

[Block Explorer](./big-dipper) - You can optionally set up a block-explorer. [forbole/big-dipper](https://github.com/CosmWasm/big-dipper)
