// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingOfEther {
    address public king;
    uint256 public balance;

    function claimThrone() external payable {
        //When funds will get locked new user will have to pay than balance + locked funds.
        require(msg.value > address(this).balance - msg.value, "Need to pay more to become the king");
        //Funds will get locked when SC will not have external or recieve fuctions
        king.call{value: balance}("");
        balance = msg.value;
        king = msg.sender;
    }
}
