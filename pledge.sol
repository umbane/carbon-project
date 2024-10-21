// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./token.sol";
import "./carboncredits.sol";

contract Pledge is Token {
    // Mapping from pledger to their pledge details
    mapping(address => PledgeDetails) public pledges;

    // Structure to hold pledge details
    struct PledgeDetails {
        address pledgee; // Added pledgee address
        uint256 mJAmount;
        uint256 aCAmount;
        uint256 carbGenerated;
        bool fulfilled;
    }

    // Event emitted when a pledge is created
    event PledgeCreated(address indexed pledger, address indexed pledgee, uint256 mJAmount, uint256 aCAmount);

    // Event emitted when a pledge is fulfilled
    event PledgeFulfilled(address indexed pledger, address indexed pledgee, uint256 carbGenerated);

    // Function to create a pledge
    function createPledge(address _pledgee, uint256 _mJAmount, uint256 _aCAmount) public {
        require(_pledgee != address(0), "Pledgee address cannot be zero");
        require(_mJAmount > 0 || _aCAmount > 0, "Pledge amount must be greater than zero");

        // Transfer tokens from pledger to contract
        if (_mJAmount > 0) {
            burnMJ(_mJAmount);
        }
        if (_aCAmount > 0) {
            burnAC(_aCAmount);
        }

        // Calculate CarB tokens generated (adjust formula as needed)
        uint256 _carbGenerated = (_mJAmount + _aCAmount) * 2; // Example formula

        // Update pledge details
        pledges[msg.sender] = PledgeDetails(_pledgee, _mJAmount, _aCAmount, _carbGenerated, false);

        // Emit event
        emit PledgeCreated(msg.sender, _pledgee, _mJAmount, _aCAmount);
    }

    // Function to fulfill a pledge (e.g., after goods/services are received)
    function fulfillPledge() public {
        require(pledges[msg.sender].fulfilled == false, "Pledge already fulfilled");

        // Mint CarB tokens to pledgee
        address _pledgee = pledges[msg.sender].pledgee;
        uint256 _carbGenerated = pledges[msg.sender].carbGenerated;
        _mint(_pledgee, _carbGenerated); // Mint to pledgee, not pledger

        // Update pledge details
        pledges[msg.sender].fulfilled = true;

        // Emit event
        emit PledgeFulfilled(msg.sender, _pledgee, _carbGenerated);
    }

    // Function to allocate a fraction of CarB to a project (requires further implementation)
    function allocateToProject(address _projectAddress, uint256 _amount) public {
        // Add logic to transfer CarB tokens to the project address
        // This requires additional considerations for project verification and governance
    }
}
