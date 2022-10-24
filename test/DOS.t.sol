// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/DOS/Victim.sol";
import "../src/DOS/Attacker.sol";

contract DOSTest is Test {
    KingOfEther game;
    KingOfEtherAttacker attacker;

    //Users
    address User1 = address(1);
    address User2 = address(2);

    function setUp() public {
        game = new   KingOfEther();
        attacker = new  KingOfEtherAttacker(address(game));
        vm.deal(User1, 10 ether);
        vm.deal(User2, 15 ether);
    }

    function testAttack() public {
        vm.prank(User1);
        game.claimThrone{value: 3 ether}();
        vm.prank(User2);
        game.claimThrone{value: 5 ether}();
        vm.prank(User1);
        game.claimThrone{value: 7 ether}();
        attacker.attack{value: 10 ether}();
        vm.prank(User2);
        vm.expectRevert(bytes("Failed to send Ether"));
        game.claimThrone{value: 15 ether}();
    }
}
