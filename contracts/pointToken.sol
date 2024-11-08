// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
contract PointToken is ERC20, Ownable {
    mapping(address => bool) public isController;

    event ControllerAdded(address controller);
    event ControllerRemoved(address controller);

    constructor() ERC20("PointToken", "PT") Ownable(msg.sender) {
    
    }

    modifier onlyController() {
        require(isController[msg.sender], "PointToken: caller is not the controller");
        _;
    }

    function addController(address controller) public onlyOwner {
        isController[controller] = true;
        emit ControllerAdded(controller);
    }

    function removeMinter(address controller) public onlyOwner {
        isController[controller] = false;
        emit ControllerRemoved(controller);
    }

    function mint(address to, uint256 amount) public onlyController {
        _mint(to, amount);
    }

    function burn(address from, uint256 amount) public onlyController {
        _burn(from, amount);
    }
}