// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.6;

import "forge-std/Test.sol";
import "../src/Overflow/Victim.sol";
import "../src/Overflow/Attacker.sol";

contract OverflowTest is Test {
    Vault vault;
    VaultAttacker attacker;

    function setUp() public {
        vault = new Vault();
        attacker = new VaultAttacker(address(vault));
    }

    function testingOverflowAttack() public {
        attacker.Attack{value: 1 ether}();
        assertEq(address(attacker).balance, 1 ether);
    }
}
