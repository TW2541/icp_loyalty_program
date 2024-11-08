// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract PlatformNft is ERC721, Ownable {
    uint256 public constant MAX_SUPPLY = 25000;
    uint256 public currentTokenId = 0;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) Ownable(msg.sender) {}

    function mint(address to) external onlyOwner {
        require(currentTokenId < MAX_SUPPLY, "Max supply reached");
        require(balanceOf(to) == 0, "Only one NFT per address");
        
        currentTokenId += 1;
        _safeMint(to, currentTokenId);
    }
}