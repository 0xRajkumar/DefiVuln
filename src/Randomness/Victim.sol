// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Flipcoin {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function flip(uint256 guess) public payable {
        require(guess == 1 || guess == 0, "Invalid guess");
        require(msg.value == 1 ether, "Invalid value");
        uint256 randomFlip = random();
        if (randomFlip == guess) {
            (bool sent,) = payable(msg.sender).call{value: address(this).balance}("");
            require(sent, "Failed to send Ether");
        }
    }

    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, owner))) % 2;
    }

    receive() external payable {}
}
