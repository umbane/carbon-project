# Token Contract Explanation

The `Token` contract is a combined ERC20 and ERC721 contract that manages two types of tokens:

* **MegaJoule (mJ):** An ERC20 fungible token representing units of energy.
* **aCNFT (aC):** An ERC721 non-fungible token representing carbon credits.

The contract also integrates with Chainlink's Verifiable Random Function (VRF) for generating verifiable randomness.  This is likely used for aspects such as determining energy usage or other random events within the system.

## Constructor

The contract's constructor initializes both the ERC20 and ERC721 aspects:

`constructor() ERC20("MegaJoule", "MJ") ERC721("ACNFT", "AC") VRFConsumerBaseV2(0x2Ca8E0C643bDe4C2D8c8B8B77586A8EDd60178B9) {}`

This line sets up the names and symbols for each token type and links the contract to a VRF Coordinator.  **The VRF Coordinator address (0x2Ca8E0C643bDe4C2D8c8B8B77586A8EDd60178B9) is a placeholder and must be replaced with the correct address for the target network before deployment.**

## Key Functions

The contract includes functions for minting, burning, and managing balances of both MJ and AC tokens.  The `requestEnergyData` function uses Chainlink VRF to generate random numbers, likely used to simulate or determine energy usage.  The `fulfillRandomWords` function processes the VRF response and mints MJ tokens based on the generated random number.

## Important Considerations

* **VRF Coordinator Address:**  Remember to replace the placeholder VRF Coordinator address with the correct address for your deployment network.
* **Further Development:** The `fulfillRandomWords` function currently uses a placeholder for energy data retrieval.  This needs to be replaced with the actual logic for obtaining and verifying energy data.

This document provides a high-level overview of the `Token` contract.  Refer to the contract's source code for detailed implementation specifics.
