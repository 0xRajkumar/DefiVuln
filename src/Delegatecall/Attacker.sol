// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DelegateAttacker {
    address delegateContractAddress;
    uint256 public number;

    function changeNumber(uint256 _number) public {
        number = _number;
    }
}
