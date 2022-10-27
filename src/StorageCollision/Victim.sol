// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Proxy {
    address public implementation; //slot0

    constructor(address _implementation) public {
        implementation = _implementation;
    }

    function testcollision() public {
        implementation.delegatecall(abi.encodeWithSignature("foo(address)", address(this)));
    }
}

contract Logic {
    address public GuestAddress; //slot0

    constructor() public {
        GuestAddress = address(0x0);
    }

    function foo(address _addr) public {
        GuestAddress = _addr;
    }
}
