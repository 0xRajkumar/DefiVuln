// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract Wallet is DSTest {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function transfer(address payable _to, uint256 _amount) public {
        require(tx.origin == owner, "Not owner");
        (bool sent,) = _to.call{value: _amount}("");
        require(sent, "Failed to send Ether");
    }
}
