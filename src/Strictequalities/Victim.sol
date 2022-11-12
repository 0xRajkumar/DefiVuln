// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

interface IReceiver {
    function received(uint256 amount) external;
}

contract UnstoppableLender is ReentrancyGuard {
    uint256 public poolBalance;

    function deposit() external payable nonReentrant {
        require(msg.value > 0, "Must deposit at least one wei");
        poolBalance = poolBalance + msg.value;
    }

    function flashLoan(uint256 borrowAmount) external nonReentrant {
        require(borrowAmount > 0, "Must borrow at least one wei");

        uint256 balanceBefore = address(this).balance;
        require(balanceBefore >= borrowAmount, "Not enough balance in pool");

        // Ensured by the protocol via the `depositTokens` function
        assert(poolBalance == balanceBefore);
        (bool sent, bytes memory data) = payable(msg.sender).call{value: borrowAmount}("");
        require(sent, "Failed to send Ether");

        IReceiver(msg.sender).received(borrowAmount);

        uint256 balanceAfter = address(this).balance;
        require(balanceAfter >= balanceBefore, "Flash loan hasn't been paid back");
    }
}
