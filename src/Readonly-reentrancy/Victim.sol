// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Invest {
    mapping(address => uint256) public amount;

    function invest() public payable {
        require(msg.value > 0, "amount should be more than zero!");
        amount[msg.sender] = amount[msg.sender] + msg.value;
    }

    function withdraw(uint256 amountToInvest) public {
        require(amount[msg.sender] >= amountToInvest, "amount should be less than invested!");
        (bool sent, bytes memory data) = payable(msg.sender).call{value: amountToInvest}("");
        require(sent, "Failed to send Ether");
        amount[msg.sender] = amount[msg.sender] - amountToInvest;
    }
}

contract InvestTracker {
    Invest invest;

    constructor(address _invest) {
        invest = Invest(_invest);
    }

    function checkInvestment(address user) public returns (uint256) {
        //Vuln is here
        return invest.amount(user);
    }
}
