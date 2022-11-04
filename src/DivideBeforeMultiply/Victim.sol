// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {
    function findPercentageOf(uint256 percentage, uint256 num) public pure returns (uint256) {
        return (num / 100) * percentage;
    }
}
