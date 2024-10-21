// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@chainlink/contracts/src/v0.8/interfaces/LinkTokenInterface.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract Token is ERC20, VRFConsumerBaseV2, ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC20("MyToken", "MTK") ERC721("MyCarbonCredit", "MCC") VRFConsumerBaseV2(0x2Ca8E0C643bDe4C2D8c8B8B77586A8EDd60178B9) {} // Replace with your VRF Coordinator address

    uint256 public mJTotalSupply;
    uint256 public aCTotalSupply;

    event MJMinted(address indexed to, uint256 amount);
    event ACMinted(address indexed to, uint256 tokenId);
    event RequestEnergyData(bytes32 indexed requestId, address indexed user);

    uint64 public s_subscriptionId;
    bytes32 public keyHash;
    uint32 public callbackGasLimit;
    uint16 public requestConfirmations;
    uint32 public numWords;
    LinkTokenInterface internal linkToken;

    function setChainlinkConfig(uint64 subscriptionId, bytes32 _keyHash, uint32 _callbackGasLimit, uint16 _requestConfirmations, uint32 _numWords, address _linkToken) public {
        s_subscriptionId = subscriptionId;
        keyHash = _keyHash;
        callbackGasLimit = _callbackGasLimit;
        requestConfirmations = _requestConfirmations;
        numWords = _numWords;
        linkToken = LinkTokenInterface(_linkToken);
    }

    function requestEnergyData(address user) public returns (bytes32 requestId) {
        requestId = requestRandomness(keyHash, requestConfirmations, callbackGasLimit, numWords);
        emit RequestEnergyData(requestId, user);
    }

    function fulfillRandomWords(uint256 requestId, uint256[] memory randomWords) internal override {
        // Placeholder - Replace with actual energy data retrieval and verification
        uint256 energyUsed = randomWords[0] % 1000; // Example: Simulate energy usage between 0 and 999
        mintMJ(msg.sender, energyUsed);
    }

    function mintMJ(address to, uint256 amount) public {
        _mint(to, amount);
        mJTotalSupply += amount;
        emit MJMinted(to, amount);
    }

    function mintAC(address to) public {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(to, newItemId);
        aCTotalSupply += 1;
        emit ACMinted(to, newItemId);
    }

    function burnMJ(uint256 amount) public {
        _burn(msg.sender, amount);
        mJTotalSupply -= amount;
    }

    function burnAC(uint256 tokenId) public {
        _burn(tokenId);
        aCTotalSupply -= 1;
    }

    function getMJBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function getACBalance(address account) public view returns (uint256) {
        return balanceOf(account);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC20) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
        return string(abi.encodePacked("ipfs://", Strings.toString(tokenId)));
    }
}
