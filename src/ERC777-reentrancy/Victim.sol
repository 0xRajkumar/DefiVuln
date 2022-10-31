// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC777/ERC777.sol";

//Maximum mints is 1,000, How can you bypass this limitation?

contract MyERC777 is ERC777 {
    uint256 maxMints = 1000;

    constructor(uint256 initialSupply) public ERC777("Gold", "GLD", new address[](0)) {
        _mint(msg.sender, initialSupply, "", "");
    }

    function mint(address account, uint256 amount, bytes memory userData, bytes memory operatorData)
        public
        returns (bool)
    {
        require(maxMints >= totalSupply()); // Limit the number of mints to 1000.
        _mint(account, amount, userData, operatorData);
        return true;
    }
}
