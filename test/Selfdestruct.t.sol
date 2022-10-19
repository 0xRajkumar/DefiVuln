// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Selfdestruct/Victim.sol";
import "../src/Selfdestruct/Attacker.sol";

contract SelfdestructTest is Test {
    EthGame ethgame;
    EthGameAttack attacker;

    function setUp() public {
        ethgame = new EthGame();
        attacker = new EthGameAttack(address(ethgame));
        vm.deal(address(attacker), 10 ether);
    }

    function testAttack() public {
        attacker.Attack();
        uint256 ethGameContractBalance = address(ethgame).balance;
        assertEq(ethGameContractBalance, 10 ether);
    }
}
