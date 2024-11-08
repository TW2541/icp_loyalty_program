// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import { PointToken } from "./pointToken.sol";
import { PlatformNft } from "./platformNft.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract Loyalty is Ownable {

    PointToken public pointToken;
    mapping(address => uint256) public nextClaimTime;

    event OffChainPurchase(address indexed buyer, uint256 amount, string refId);

    address[] public nftCollections;

    constructor(PointToken _pointToken) Ownable(msg.sender){
        pointToken = _pointToken;
    }

    function createNftCollection(string memory name, string memory symbol) public {
        PlatformNft nft = new PlatformNft(name, symbol);
        nftCollections.push(address(nft));
    }

    function mintNft(address nftCollection) public {
        require(pointToken.balanceOf(msg.sender) >= 100 ether, "loyalty: insufficient points");
        pointToken.burn(msg.sender, 100 ether);
        PlatformNft(nftCollection).mint(msg.sender);
    }

    function dailyRewardClaim() public {
        require(nextClaimTime[msg.sender] <= block.timestamp, "loyalty: already claimed today");
        nextClaimTime[msg.sender] = block.timestamp + 1 days;
        pointToken.mint(msg.sender, 1 ether);
    }

    function offChainPurchase(uint256 amount, string memory refId) public payable {
        uint256 nftOwned = 0;
        for (uint256 i = 0; i < nftCollections.length; i++) {
            if (PlatformNft(nftCollections[i]).balanceOf(msg.sender) > 0) {
                nftOwned++;
            }
        }

        if(nftOwned > 0) {
            uint256 discountPercentage = nftOwned > 100 ? 100 : nftOwned;
            uint256 discountedAmount = (amount * (100 - discountPercentage)) / 100;

            require(msg.value == discountedAmount, "loyalty: incorrect discounted payment amount");
            emit OffChainPurchase(msg.sender, amount, refId);
        }
        else {
            require(msg.value == amount, "loyalty: incorrect payment amount");
            emit OffChainPurchase(msg.sender, amount, refId);
        }
    }

    function withdraw() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}