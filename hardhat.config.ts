import type { HardhatUserConfig } from "hardhat/config";

import hardhatToolboxViemPlugin from "@nomicfoundation/hardhat-toolbox-viem";

import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-verify"; // optional: für Verifikation
import "dotenv/config";

const { SEPOLIA_RPC_URL, PRIVATE_KEY } = process.env;

const config: HardhatUserConfig = {
  plugins: [hardhatToolboxViemPlugin],
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL ?? '',
      accounts: PRIVATE_KEY ? [PRIVATE_KEY] : [],
      chainId: 11155111,
      type: 'http'
    },
  },
};

export default config;
