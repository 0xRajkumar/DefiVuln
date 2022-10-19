// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTContract is ERC721 {
    using Counters for Counters.Counter;

    Counters.Counter _tokenIds;
    string public baseURI = "XYZ";
    uint256 constant MAX_NFTS = 15;
    uint256 constant MAX_MINT_PER_PERSON = 5;

    constructor() ERC721("Re-entrance", "RE") {}

    function mint(uint256 _numberOfNfts) public {
        require(_tokenIds.current() + _numberOfNfts <= MAX_NFTS, "You can't mint more than max NFT's");
        require(_numberOfNfts > 0, "Number of NFT's can be't zero");
        uint256 userBalance = balanceOf(msg.sender);
        require(_numberOfNfts + userBalance <= MAX_MINT_PER_PERSON, "You can't mint more than max mint per person");
        for (uint256 i; i < _numberOfNfts; i++) {
            _tokenIds.increment();
            _safeMint(msg.sender, _tokenIds.current());
        }
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory __baseURI) external {
        baseURI = __baseURI;
    }
}
