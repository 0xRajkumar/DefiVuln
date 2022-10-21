// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReputationContract {
    struct Reputation {
        string reputationName;
        uint256 reputation;
    }

    mapping(address => Reputation) userReputation;

    function deposit() public payable {
        require(msg.value > 0, "Insufficient Value");
        Reputation storage user = userReputation[msg.sender];
        user.reputation = user.reputation + msg.value;
        user.reputationName = reputationName(user.reputation);
    }

    function withDraw(uint256 amount) public {
        //Data cached
        Reputation memory user = userReputation[msg.sender];
        require(user.reputation >= amount, "Insufficient amount");
        //Data updated
        updateReputation(msg.sender, amount);
        //Outdated cached data used
        string memory name = reputationName(user.reputation);
        updateReputationName(msg.sender, name);
    }

    function updateReputation(address userAddress, uint256 amount) private {
        Reputation storage user = userReputation[userAddress];
        (bool sent, bytes memory data) = payable(userAddress).call{value: amount}("");
        user.reputation = user.reputation - amount;
    }

    function updateReputationName(address userAddress, string memory name) private {
        Reputation storage user = userReputation[userAddress];
        user.reputationName = name;
    }

    function reputationName(uint256 reputation) public returns (string memory name) {
        if (reputation >= 100) {
            return "Legend";
        } else {
            return "Normal";
        }
    }

    function userReputationName(address userAddress) public returns (string memory name) {
        return userReputation[userAddress].reputationName;
    }
}
