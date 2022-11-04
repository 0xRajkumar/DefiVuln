// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/DivideBeforeMultiply/Victim.sol";
import "../src/DivideBeforeMultiply/Attacker.sol";

contract DivideBeforeMultiplyTest is Test {
    Calculator calc;
    CalculatorAttacker attacker;

    function setUp() public {
        calc = new Calculator();
        attacker = new CalculatorAttacker(address(calc));
    }

    function testAttack() public {
        uint256 ans = attacker.attack(10, 90);
        assertEq(ans, 0);
    }
}
