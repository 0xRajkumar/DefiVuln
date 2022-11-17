// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Readonly-reentrancy/Victim.sol";
import "../src/Readonly-reentrancy/Attacker.sol";

contract TesTest is Test {
    Invest invest;
    InvestTracker tracker;
    InvestTrackerAttacker attacker;

    function setUp() public {
        invest = new Invest();
        tracker = new InvestTracker(address(invest));
        attacker = new InvestTrackerAttacker(address(tracker),payable(address(invest)));
    }

    function testAttack() public {
        attacker.Attack{value: 10 ether}();
    }
}
