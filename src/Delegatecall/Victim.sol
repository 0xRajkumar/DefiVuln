// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delegate {
    uint256 public number;

    function changeNumber(uint256 _number) public {
        number = _number;
    }
}

contract Proxy {
    address public delegateContractAddress;
    uint256 public number;

    constructor(address _delegateContractAddress) {
        delegateContractAddress = _delegateContractAddress;
    }

    function delegateChangeNumber(uint256 _num) public {
        delegateContractAddress.delegatecall(abi.encodeWithSignature("changeNumber(uint256)", _num));
    }
}
