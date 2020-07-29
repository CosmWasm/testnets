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

## Connecting

The configuration can be [downloaded here](./config).
Please `source config` to get all variable you need.

With those, you can follow the
[official instructions](https://docs.cosmwasm.com/testnets/testnets.html)
 on how to connect to a testnet.
Or just connect your command-line client. In order to build customized wasmd executables `corald` and `coralcli`,
clone `wasmd` repo and run `make build-coral` on the root of the project.

The [genesis file](./genesis.json) is also available here.

## Web endpoints

Here we list all explorers, wallets, and apps you can access with a browser:

* [Wasm Glass](https://demonet.wasm.glass) - contract explorer
* [Name App](https://cosmwasm.github.io/name-app/) - Sample dApp interface to use the 
  [nameservice contract](https://github.com/CosmWasm/cosmwasm-examples/tree/nameservice-0.5.2/nameservice) 