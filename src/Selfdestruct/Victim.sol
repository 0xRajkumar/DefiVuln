// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";

contract EthGame {
    uint256 playingFees = 1 ether;
    uint256 private targetAmount = 10 ether;
    address winner;

    function play() public payable {
        require(msg.value == 1 ether, "Insufficient fee");
        uint256 amount = address(this).balance;
        require(amount <= targetAmount, "Game is over");
        if (amount == targetAmount) winner = msg.sender;
    }

    function claimReward() public {
        require(msg.sender == winner, "You are not winner ");
        (bool sent,) = payable(msg.sender).call{value: address(this).balance}("");
        require(sent, "Failed to transfer");

        //Game Reset:
        winner = address(0);
    }
}
