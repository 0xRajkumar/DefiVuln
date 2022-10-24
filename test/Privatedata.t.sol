// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Privatedata/Victim.sol";
import "../src/Privatedata/Attacker.sol";

contract PrivatedataTest is Test {
    UnlockGame game;
    UnlockGameAttacker attacker;

    function setUp() public {
        game = new UnlockGame{value:10 ether}(12345678);
        attacker = new UnlockGameAttacker(address(game));
    }

    function testAttack() public {
        attacker.Attack();
        assertEq(address(attacker).balance, 10 ether);
    }
}
