import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { ethers } from "hardhat";

export default buildModule("PointToken", (module) => {
  const pointToken = module.contract("PointToken");

  return {pointToken};
});

// Deploy Command: npx hardhat ignition deploy ignition/modules/pointToken.ts --network bitfinityTestnet
// Deployed Address: 0xBecA48e964fAF9fe4D51E3C6153cDb5E28089243