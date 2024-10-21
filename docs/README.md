# Carbon Credits Smart Contract Documentation

This document outlines the relationships between the Solidity smart contracts: `carboncredits.sol`, `credittoken.sol`, `certification.sol`, `token.sol`, `integration/IntegrationContract.sol`, and `pledge.sol`.

## Contract Relationships

* **`carboncredits.sol`:** This contract manages the registration of carbon credit holders, verifiers, and customers. It holds the core data about these entities, including their names, IDs, and associated addresses.

* **`credittoken.sol`:** This contract inherits from `carboncredits.sol` and OpenZeppelin's ERC20 contract. It manages the creation, transfer, and burning of carbon credits as ERC20 tokens. It interacts with `carboncredits.sol` to access and modify data about credit holders and verifiers. Key functionalities include minting new tokens, transferring credits between accounts, and burning tokens.

* **`certification.sol`:** This contract inherits from `credittoken.sol`. It represents a specific certification standard (Gold Standard in this example) and adds functionality related to certification and minting of certified carbon credits. It uses functions from `credittoken.sol` to manage the tokens and interacts with the underlying data structures in `carboncredits.sol`.

* **`token.sol`:** This contract is an ERC20 token contract that manages two types of tokens: mJ (MuizenJoules) and aC (carbon credits). It uses Chainlink VRF for verifying energy usage data and minting mJ tokens.  It also includes functions for minting, burning, and retrieving balances for both token types.

* **`integration/IntegrationContract.sol`:** This contract integrates the `carboncredits.sol`, `credittoken.sol`, and `token.sol` contracts. It includes functions to accrue aC tokens based on issued carbon credits and to process mJ tokens for aC tokens using an external API.  It inherits from `CarbonCredits` and `CreditToken`, allowing it to interact directly with their functionalities.

* **`pledge.sol`:** This contract allows users to pledge mJ and/or aC tokens to generate CarB tokens.  CarB tokens are then transferred to a designated pledgee, implementing a Pay-it-Forward mechanism.  CarB tokens can be used to purchase goods, services, and energy, or allocated to worthy projects. The contract interacts with `token.sol` to manage token transfers and minting, and it may interact with `carboncredits.sol` for additional data or verification purposes.


## Overall Architecture

The contracts work together in a layered architecture:

1. **Data Management (`carboncredits.sol`):** Provides the core data structures and functions for managing participants in the carbon credit system.

2. **Tokenization (`credittoken.sol`):** Implements the ERC20 token standard to represent and manage carbon credits as fungible tokens. It relies on the data in `carboncredits.sol`.

3. **Certification (`certification.sol`):** Adds a layer of certification-specific logic, building upon the tokenization functionality in `credittoken.sol` and using the data from `carboncredits.sol`.

4. **Energy and Carbon Tokenization (`token.sol`):** Manages the mJ and aC tokens, integrating with Chainlink VRF for data verification.

5. **Integration (`integration/IntegrationContract.sol`):** Connects the data management, tokenization, and certification layers with the energy and carbon token contract (`token.sol`), facilitating the exchange between mJ and aC tokens via an external API.

6. **Pledging (`pledge.sol`):** Allows users to pledge mJ and/or aC tokens to generate CarB tokens, which are then transferred to a designated pledgee via a Pay-it-Forward mechanism. CarB tokens can be used for various purposes, including purchasing goods and services or supporting projects.


This layered approach allows for modularity and extensibility. Future versions could add more certification standards or other features by creating new contracts that inherit from existing ones.
