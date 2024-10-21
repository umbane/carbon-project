// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./credittoken.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Certification is CreditToken, ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("Gold Standard Certificate", "GS") public {}

    string public constant name = "Gold Standard";
    string public constant symbol = "GS";

    mapping(uint256 => address) internal idToOwner;
    mapping(uint256 => address) internal idToApproval;
    mapping(address => uint256) private ownerToNFTokenCount;
    mapping(address => uint256) public burnedTokens;

    event CertificateMinted(address indexed to, uint256 tokenId);

    function addBurnedTokens(address holder) public {
        if (burnTokens()) {
            uint256 burnedTok = tokensApprovedForBurn[holder];
            burnedTokens[holder] += burnedTok;
        }
    }

    function mint(address _to, uint256 _amount) public {
        require(_to != address(0), "ZERO_ADDRESS");
        for (uint256 i = 0; i < _amount; i++) {
            _tokenIds.increment();
            uint256 newItemId = _tokenIds.current();
            _safeMint(_to, newItemId);
            emit CertificateMinted(_to, newItemId);
        }
    }

    function _addNFToken(address _to, uint256 _tokenId) internal virtual {
        require(idToOwner[_tokenId] == address(0), "NFT_ALREADY_EXISTS");
        idToOwner[_tokenId] = _to;
        ownerToNFTokenCount[_to] = ownerToNFTokenCount[_to] + 1;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        // Implement your logic to generate the tokenURI here.  This is a placeholder.
        return string(abi.encodePacked("ipfs://", Strings.toString(tokenId)));
    }
}
