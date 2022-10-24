// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Txorigin/Victim.sol";
import "../src/Txorigin/Attacker.sol";

contract TxoriginTest is Test {
    Wallet wallet;
    WalletAttacker attacker;
    //Users
    address ownerAddress = address(1);
    address attackerAddress = address(2);

    function setUp() public {
        vm.prank(ownerAddress);
        vm.deal(ownerAddress, 101 ether);
        wallet = new Wallet{value:100 ether}( );
        vm.prank(attackerAddress);
        attacker = new WalletAttacker(address(wallet));
    }

    function testAttack() public {
        vm.prank(ownerAddress, ownerAddress);
        address(attacker).call{value: 1 ether}("");
        assertEq(attackerAddress.balance, 100 ether);
    }
}
