// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";

contract CalculatorAttacker {
    Calculator calc;

    constructor(address _CalcAddress) {
        calc = Calculator(_CalcAddress);
    }

    function attack(uint256 percentage, uint256 num) public view returns (uint256) {
        // If of is lower than 100 then it will show zero
        return calc.findPercentageOf(percentage, num);
    }
}
