// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/Reentrancy/Victim.sol";
import "../src/Reentrancy/Attacker.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract ReentrancyTest is IERC721Receiver, Test {
    NFTContract victimNFTContract;
    NFTContractAttack attacker;

    function setUp() public {
        victimNFTContract = new NFTContract();
        attacker = new NFTContractAttack(address(victimNFTContract));
    }

    function testingMint() public {
        victimNFTContract.mint(5);
        uint256 mintedByOwner = victimNFTContract.balanceOf(address(this));
        assertEq(mintedByOwner, 5);
    }

    function testAttack() public {
        victimNFTContract.mint(5);
        attacker.Attack(5);
        uint256 totalMintedByAttacker = victimNFTContract.balanceOf(address(attacker));
        assertEq(totalMintedByAttacker, 15);
    }

    function onERC721Received(address, address, uint256, bytes memory) public pure override returns (bytes4) {
        return this.onERC721Received.selector;
    }
}
