// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Outdatedcache/Victim.sol";
import "../src/Outdatedcache/Attacker.sol";

contract OutdatedcacheTest is Test {
    ReputationContract reputationContract;
    ReputionAttacker attacker;

    function setUp() public {
        reputationContract = new ReputationContract();
        attacker = new  ReputionAttacker(address(reputationContract));
    }

    function testAttack() public {
        vm.deal(address(attacker), 100);
        attacker.Attack();
        string memory attackerReputationName = reputationContract.userReputationName(address(attacker));
        assertEq("Legend", attackerReputationName);
    }
}
