// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ContractChecker {
    bool public wasContract;

    function isContract(address account) public view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    function interact() public {
        wasContract = isContract(msg.sender);
    }
}
