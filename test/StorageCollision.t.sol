// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/StorageCollision/Victim.sol";
import "../src/StorageCollision/Attacker.sol";

contract StorageCollisionTest is Test {
    Proxy proxy;
    ProxyAttacker attacker;

    function setUp() public {
        Logic logic = new Logic();
        proxy = new Proxy(address(logic));
        attacker = new ProxyAttacker(address(proxy));
    }

    function testAttack() public {
        attacker.Attack();
        assertEq(proxy.implementation(), address(proxy));
    }
}
