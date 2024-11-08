import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";
import { ethers } from "hardhat";

export default buildModule("Loyalty", (module) => {
  const loyalty = module.contract("Loyalty", ["0xBecA48e964fAF9fe4D51E3C6153cDb5E28089243"]);

  return {loyalty};
});

// Deploy Command: npx hardhat ignition deploy ignition/modules/loyalty.ts --network bitfinityTestnet
// Deployed Address: 0x1aeD835C7B3f6e549648ADB43A54915208A99e32