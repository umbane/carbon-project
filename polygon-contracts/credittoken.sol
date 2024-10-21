// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./carboncredits.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CreditToken is CarbonCredits, ERC20 {
    uint256 public totalSupply;
    uint256 public supply;
    uint256 public tokenBurnedCount;

    constructor() ERC20("Carbon", "C") public {
        _setupDecimals(0);
    }

    mapping(address => uint256) public balanceOf;
    mapping(address => uint256) public approvedCredits;
    mapping(address => uint256) public tokensApprovedForBurn;

    modifier onlyVerifier() {
        require(msg.sender == verifiers[verifierCount].addr, "Only verifiers can call this function");
        _;
    }

    modifier onlyCreditHolder() {
        require(msg.sender == creditHolders[totalRegistered].addr, "Only credit holders can call this function");
        _;
    }

    function approveCreditsHeld(address _holder) public onlyVerifier {
        uint256 cred = creditHolders[totalRegistered].creditsHeld;
        approvedCredits[_holder] += cred;
    }

    function createCarbonToken() public onlyCreditHolder returns (uint256) {
        address owner = creditHolders[totalRegistered].addr;
        supply = approvedCredits[owner];
        totalSupply = totalSupply + supply;
        balanceOf[owner] = balanceOf[owner] + supply;
        _mint(msg.sender, supply);
        return totalSupply;
    }

    function transferCredits(address to, uint256 value) public onlyCreditHolder {
        _transfer(msg.sender, to, value);
        balanceOf[msg.sender] = balanceOf[msg.sender] - value;
        balanceOf[to] = balanceOf[to] + value;
    }

    function transferCreditsFrom(address from, address to, uint256 value) public {
        transferFrom(from, to, value);
        balanceOf[from] = balanceOf[from] - value;
        balanceOf[to] = balanceOf[to] + value;
    }

    function approveBurn(uint256 carbonTokens, address holder) public onlyVerifier {
        tokensApprovedForBurn[holder] += carbonTokens;
    }

    function burnTokens() public onlyOwner returns (bool) {
        _burn(msg.sender, tokensApprovedForBurn[msg.sender]);
        totalSupply = totalSupply - tokensApprovedForBurn[msg.sender];
        balanceOf[msg.sender] = balanceOf[msg.sender] - tokensApprovedForBurn[msg.sender];
        return true;
    }

    function buyCarbonCredits(uint256 amount) public payable {
        uint256 value = amount * 1;
        require(msg.value > 0, "Value must be greater than zero");
        transferCreditsFrom(address(this), msg.sender, value);
    }
}
