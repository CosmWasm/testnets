import axios from  "axios"
import fs from "fs"
import { SigningCosmWasmClient, CosmWasmFeeTable} from "@cosmjs/cosmwasm-stargate"
import { GasPrice, Secp256k1HdWallet, GasLimits, makeCosmoshubPath } from "@cosmjs/launchpad"
import { Slip10RawIndex } from "@cosmjs/crypto"
import path from "path"

interface Options {
  readonly httpUrl: string
  readonly networkId: string
  readonly feeToken: string
  readonly gasPrice: GasPrice
  readonly bech32prefix: string
  readonly hdPath: readonly Slip10RawIndex[]
  readonly faucetUrl?: string
  readonly defaultKeyFile: string
}

const defaultSendFee = calculateFee(80_000, defaultGasPrice);
const defaultUploadFee = calculateFee(1_500_000, defaultGasPrice);
const defaultInstantiateFee = calculateFee(500_000, defaultGasPrice);
const defaultExecuteFee = calculateFee(200_000, defaultGasPrice);
const defaultMigrateFee = calculateFee(200_000, defaultGasPrice);
const defaultUpdateAdminFee = calculateFee(80_000, defaultGasPrice);
const defaultClearAdminFee = calculateFee(80_000, defaultGasPrice);

const oysternetOptions: Options = {
  httpUrl: 'http://rpc.oysternet.cosmwasm.com',
  networkId: 'oysternet-1',
  gasPrice:  GasPrice.fromString("0.01usponge"),
  bech32prefix: 'wasm',
  feeToken: 'usponge',
  faucetUrl: 'https://faucet.oysternet.cosmwasm.com/credit',
  hdPath: makeCosmoshubPath(0),
  defaultKeyFile: path.join(process.env.HOME, ".oysternet.key"),
}

const pebblenetOptions: Options = {
  httpUrl: 'https://rpc.pebblenet.cosmwasm.com',
  networkId: 'pebblenet-1',
  gasPrice:  GasPrice.fromString("0.01upebble"),
  bech32prefix: 'wasm',
  feeToken: 'upebble',
  faucetUrl: 'https://faucet.pebblnet.cosmwasm.com/credit',
  hdPath: makeCosmoshubPath(0),
  defaultKeyFile: path.join(process.env.HOME, ".pebblenet.key"),
}

interface Network {
  setup: (password: string, filename?: string) => Promise<[string, SigningCosmWasmClient]>
  recoverMnemonic: (password: string, filename?: string) => Promise<string>
}

const useOptions = (options: Options): Network => {

  const loadOrCreateWallet = async (options: Options, filename: string, password: string): Promise<Secp256k1HdWallet> => {
    let encrypted: string;
    try {
      encrypted = fs.readFileSync(filename, 'utf8');
    } catch (err) {
      // generate if no file exists
      const wallet = await Secp256k1HdWallet.generate(12, {hdPaths: [options.hdPath], prefix: options.bech32prefix});
      const encrypted = await wallet.serialize(password);
      fs.writeFileSync(filename, encrypted, 'utf8');
      return wallet;
    }
    // otherwise, decrypt the file (we cannot put deserialize inside try or it will over-write on a bad password)
    const wallet = await Secp256k1HdWallet.deserialize(encrypted, password);
    return wallet;
  };

  const connect = async (
    wallet: Secp256k1HdWallet,
    options: Options
  ): Promise<SigningCosmWasmClient> => {
    const clientOptions = {
      prefix: options.bech32prefix,
      gasPrice: options.gasPrice,
      gasLimits: options.gasLimits
    }
    return await SigningCosmWasmClient.connectWithSigner(options.httpUrl, wallet, clientOptions)
  };

  const hitFaucet = async (
    faucetUrl: string,
    address: string,
    denom: string
  ): Promise<void> => {
    await axios.post(faucetUrl, {denom, address});
  }

  const setup = async (password: string, filename?: string): Promise<[string, SigningCosmWasmClient]> => {
    const keyfile = filename || options.defaultKeyFile;
    const wallet = await loadOrCreateWallet(oysternetOptions, keyfile, password);
    const client = await connect(wallet, oysternetOptions);

    const [account] = await wallet.getAccounts();
    // ensure we have some tokens
    if (options.faucetUrl) {
      const tokens = await client.getBalance(account.address, options.feeToken)
      if (tokens.amount === '0') {
        console.log(`Getting ${options.feeToken} from faucet`);
        await hitFaucet(options.faucetUrl, account.address, options.feeToken);
      }
    }

    return [account.address, client];
  }

  const recoverMnemonic = async (password: string, filename?: string): Promise<string> => {
    const keyfile = filename || options.defaultKeyFile;
    const wallet = await loadOrCreateWallet(oysternetOptions, keyfile, password);
    return wallet.mnemonic;
  }

  return {setup, recoverMnemonic};
}
