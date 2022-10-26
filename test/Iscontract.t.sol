// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Iscontract/Victim.sol";
import "../src/Iscontract/Attacker.sol";

contract IscontractTest is Test {
    ContractChecker checker;
    ContractCheckerAttacker attacker;

    function setUp() public {
        checker = new ContractChecker();
    }

    function testAttack() public {
        attacker = new ContractCheckerAttacker(address(checker));
        assertEq(checker.wasContract(), false);
    }
}
