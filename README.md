# ICP Loyalty Program Bounty

## Intro
This project will have 3 solidity smart contracts where 2 of them will be deploy via hardhat ignition which is 
- PointToken Contract -> Represent as point using ERC-20 standard
- Loyalty Contract -> Represent business logic for loyalty program

and last one will be contract template which is
- PlatformNft Contract -> Represent as ERC-721 standard (NFT) using like discount coupon

## Deployment
This project was deployed into Bitfinity Testnet using hardhat ignition

**Point Token Contract**

	Deploy Command: npx hardhat ignition deploy ignition/modules/pointToken.ts --network bitfinityTestnet
	Deployed Address: 0xBecA48e964fAF9fe4D51E3C6153cDb5E28089243
	Tx: https://explorer.testnet.bitfinity.network/tx/0x7569baa15f552933981584f370571a52b9112740cbed9e47265e834fd7a4f655

**Loyalty Contract**

	Deploy Command: npx hardhat ignition deploy ignition/modules/loyalty.ts --network bitfinityTestnet
	Deployed Address: 0x1aeD835C7B3f6e549648ADB43A54915208A99e32
	Tx: https://explorer.testnet.bitfinity.network/tx/0x39aa426eae2b0d38219558bfa26a1b44e9e3fc5075ea5e14e938e74184c8fdc9

## Scenario Flow
1. **Point Token Contract** can be mint and burn point by controller which is **Loyalty Contract** so we to use `PointToken.addController()` to make mint and burn available in **Loyalty Contract**
	>As for this scenario, at 100 ethers of Point Token can be claim Platform NFT
	
2. When user login and sign into web3 platform, **Loyalty Contract** has `Loyalty.dailyRewardClaim()` to mint Point Token into user wallet (1 ether)
3. Owner of **Loyalty Contract** can create NFT which using **PlatformNft Contract** to create Platform NFT when user hold this it can use as a discount when call  `Loyalty.offChainPurchase()` and owner can also call `Loyalty.withdraw()` to redeem all native when user made a purchase
4. When user call `Loyalty.offChainPurchase()` user will get point token equal to amount that they purchase and this function will be emit event which can be use as proof of purchasing
5. When point token is enough (100 ethers) user can call `Loyalty.mintNft()` to mint Platform NFT which using as 1% discount when call `Loyalty.offChainPurchase()`
