import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

import * as fs from 'fs'

const mnemonicFileName = process.env.MNEMONIC_FILE!
let mnemonic = 'test '.repeat(11) + 'junk'
if (fs.existsSync(mnemonicFileName)) { mnemonic = fs.readFileSync(mnemonicFileName, 'ascii') }

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const config: HardhatUserConfig = {
  solidity: {
    
    compilers: [{
      version: '0.8.24',
      settings: {
        optimizer: { enabled: true, runs: 100000000 },
      }
    }]
  },
  networks: {
    bitfinityTestnet: {
      url: 'https://testnet.bitfinity.network/',
      gas: "auto",
      gasPrice: "auto",
      accounts: [
        process.env.PRIVATE_KEY!,
      ],
      chainId: 355113,
    },
  },
  mocha: {
    timeout: 10000
  },
}

export default config