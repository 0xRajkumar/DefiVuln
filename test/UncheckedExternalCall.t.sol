// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/UncheckedExternalCall/Victim.sol";
import "../src/UncheckedExternalCall/Attacker.sol";

contract UncheckedExternalCallTest is Test {
    KingOfEther game;
    KingOfEtherAttacker attacker;

    //Users
    address User1 = address(0x1);
    address User2 = address(0x2);
    address attackerUser = address(0xdead);

    function setUp() public {
        game = new   KingOfEther();
        attacker = new  KingOfEtherAttacker(address(game));
        vm.deal(User1, 20 ether);
        vm.deal(User2, 35 ether);
        vm.deal(attackerUser, 10 ether);
    }

    function testAttack() public {
        vm.prank(User1);
        emit log_named_uint("Here", game.balance());
        game.claimThrone{value: 3 ether}();
        vm.prank(User2);
        game.claimThrone{value: 5 ether}();
        vm.prank(attackerUser);
        attacker.attack{value: 10 ether}();

        vm.prank(User1);
        game.claimThrone{value: 20 ether}();
        vm.prank(User2);
        vm.expectRevert(bytes("Need to pay more to become the king"));
        //Becouse of locked 10 ether we will need to pay more than 10 + 20 eth
        game.claimThrone{value: 30 ether}();
    }
}
