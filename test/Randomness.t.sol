// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Randomness/Victim.sol";
import "../src/Randomness/Attacker.sol";

contract RandomnessTest is Test {
    Flipcoin game;
    FlipcoinAttacker attacker;

    function setUp() public {
        game = new Flipcoin();
        attacker = new FlipcoinAttacker(payable(address(game)));
        vm.deal(address(game), 10 ether);
    }

    function testAttack() public {
        attacker.Attack{value: 1 ether}();
        assertEq(address(attacker).balance, 11 ether);
    }
}
