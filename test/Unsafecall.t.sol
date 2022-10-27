// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Unsafecall/Victim.sol";
import "../src/Unsafecall/Attacker.sol";

contract UnsafecallTest is Test {
    TokenWhale TokenWhaleContract;
    TokenWhaleAttacker attacker;

    function setUp() public {
        TokenWhaleContract = new TokenWhale();
        attacker = new TokenWhaleAttacker(address(TokenWhaleContract));
    }

    function testAttack() public {
        attacker.Attack();
        assertEq(1000, TokenWhaleContract.balanceOf(address(attacker)));
    }
}
