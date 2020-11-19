# Testnet Launch Checklist and Instructions

You can copy paste this section to new testnet folder to check you follow the steps correctly.

All scripts rely heavily on environment variables to work correctly.
You will want to `source ../<testnetname>/defaults.env` as a basis, then
possibly declare a few more variables as desired.

## Genesis Configuration

- [ ] Checkout to a new branch
- [ ] Duplicate latest network directory and rename it to `newnet`
- [ ] Clean genesis account and gentx in genesis file
- [ ] Update chain-id
- [ ] Update start time in genesis file
- [ ] Update staking and fee token
- [ ] Update replace bech32 addresses
- [ ] Create a reserve address and add it to genesis, Make sure reserve has enough stake and fee tokens
- [ ] Add gen tx for validator node, collect-gentx, save `config/node_key.json` and `config/priv_validator.json`, delete them on this folder.
  While setting up validator move these keys to the validator machine.
- [ ] Merge the branch to master

## Full Node

### Validator

- [ ] Spin a new server, Hetzner CX21 is sufficient.
- [ ] Follow [node instructions](node/README.md).
- [ ] Copy output of `node_id.sh` this will give you the node id to use in sentry/seed set up.
- [ ] Merge the changes to the genesis to testnets repo.

### Sentry

- [ ] Spin a new server 2 CPU, 4 GB RAM, 40 GB SSD is sufficient.
- [ ] Follow [node instructions](node/README.md).
- [ ] Setup [Public Endpoints](./endpoints): ssl certs and nginx config to serve rpc and lcd endpoints over https. 
- [ ] Make sure RPC endpoint is working.
- [ ] Update `SEED_NODE` in newnet/defaults.env.
- [ ] Merge the changes to the genesis to testnets repo.
 
### Faucet

[Faucet](./faucet) - Also, you can optionally set up a faucet. However, you need to feed it with tokens
so it has something to give out.

### Block Explorer

[Block Explorer](./big-dipper) - You can optionally set up a block-explorer. [forbole/big-dipper](https://github.com/CosmWasm/big-dipper)
