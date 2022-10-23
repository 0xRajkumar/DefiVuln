// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Visibility/Victim.sol";
import "../src/Visibility/Attacker.sol";

contract VisibilityTest is Test {
    ownerGame game;
    ownerGameAttacker attacker;

    function setUp() public {
        game = new ownerGame();
        attacker = new ownerGameAttacker(address(game));
    }

    function testAttack() public {
        attacker.Attack();
        assertEq(game.owner(), address(attacker));
    }
}
