# Coral (WIP)

A permissionless testing network running

- **wasmd version**: v0.10.0
- **wasmd build command**: `make build-coral`
- **cosmosjs version**: v0.22.0
- **start**: 11th August 2020
- **end**: not yet finished

## Purpose

This is long-term playground network where developers can test their contracts validators test their infrastructure.
You can relate it to Ethereum's Rinkeby.

## Get Genesis Tokens

Fork this repo and check it out, build the `coral` binary from 
[`wasmd`](https://github.com/CosmWasm/wasm), and make a PR updating the
genesis file:

```shell
coral keys add validator
corald init dummy
corald add-genesis-account $(coral keys show -a validator) 100000000ushell,100000000ureef
cat $HOME/.corald/config/genesis.json | jq '.app_state.auth.accounts [0]' > /tmp/new_acc.json
NEW_GEN=$(jq '.app_state.auth.accounts += [input]' ./config/genesis.json /tmp/new_acc.json) && echo "$NEW_GEN" > ./config/genesis.json

```

## Connecting

The configuration can be [downloaded here](./config.env).
Please `source config` to get all variable you need.

With those, you can follow the
[official instructions](https://docs.cosmwasm.com/testnets/testnets.html)
 on how to connect to a testnet.
Or just connect your command-line client. In order to build customized wasmd executables `corald` and `coral`,
clone `wasmd` repo and run `make build-coral` on the root of the project.

The [genesis file](./genesis.json) is also available here.

## Web endpoints

Here we list all explorers, wallets, and apps you can access with a browser:

* [Wasm Glass](https://demonet.wasm.glass) - contract explorer
* [Name App](https://cosmwasm.github.io/name-app/) - Sample dApp interface to use the 
  [nameservice contract](https://github.com/CosmWasm/cosmwasm-examples/tree/nameservice-0.5.2/nameservice) 