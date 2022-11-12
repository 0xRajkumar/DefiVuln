// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Strictequalities/Victim.sol";
import "../src/Strictequalities/Attacker.sol";

contract DelegatecallTest is Test {
    UnstoppableLender lender;
    UnstoppableLenderAttacker attacker;

    function setUp() public {
        lender = new UnstoppableLender();
        attacker = new UnstoppableLenderAttacker(payable(address(lender)));
        lender.deposit{value: 10 ether}();
    }

    function testAttack() public {
        attacker.Attack{value: 1 ether}();
        vm.expectRevert();
        lender.flashLoan(8 ether);
    }

    function received(uint256 amount) external payable {
        (bool sent, bytes memory data) = payable(msg.sender).call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}
