// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UnlockGame {
    //slot 0
    uint256 private password;

    constructor(uint256 _password) payable {
        password = _password;
    }

    function unlock(uint256 _password) public {
        require(password == _password, "Wrong Password");
        (bool sent, bytes memory data) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send ether");
    }
}
