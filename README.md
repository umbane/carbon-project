# Carbon Credits and Energy System

This project integrates a carbon credit system with an energy token system.

# Rational

Currently City of Cape Town electricity users may feed electricity into the grid in exchange for a modest credit on the network. This is all good and well, but it creates a vertical monopoly where users are prevented from sharing energy and/or surplus credits directly with their neighbours and the community at large. In addition, only feed-in energy is rewarded. 

We propose the addition of a blockchain token (mJ) which is minted whenever there is "proof of production" of one watt of domestic energy, the mJ can then be traded for a carbon credit (aC) via an API to the JSE carbon trading desk or other carbon trading projects.

Benefits include reward of domestic production irrespective of the feed-in tariff, and ability to store tokens for future economic advantage. See our [white paper]()
https://github.com/Muizenberg-Electricity-Cooperative/Carbon-Project/blob/main/docs/white-paper.md
## Project Structure

* **`carboncredits.sol`:** Core contract for managing carbon credit holders, verifiers, and customers.
* **`credittoken.sol`:** ERC20 token contract for carbon credits, inheriting from `carboncredits.sol`.
* **`certification.sol`:** Contract for a specific certification standard (e.g., Gold Standard), inheriting from `credittoken.sol`.
* **`integration/IntegrationContract.sol`:** Contract integrating the carbon credit system with the energy token system.
* **`token.sol`:** Contract for energy (mJ) and carbon credit (aC) tokens.
* **`/home/dav/Projects/mecc-token/contracts/Token.sol`:** Contract for energy (mJ) and carbon credit (aC) tokens.  **Note:** This contract resides in a separate repository and needs to be merged into this project.
* **`docs/README.md`:** Documentation for the carbon credit system.
* **`docs/chainlink_integration.md`:** Documentation for Chainlink oracle integration.
* **`docs/system_diagram.md`:** Mermaid diagram visualizing the contract system.

## Integration Details

The `IntegrationContract.sol` facilitates the interaction between the carbon credit system and the energy token system.  It allows for the accrual of aC tokens based on carbon credit issuance and potentially mJ token usage (requires further implementation).  A Chainlink oracle is planned for verifying energy usage data and minting mJ tokens.


## Polygon Network Refactoring

Refactoring this project to the Polygon network would involve recompiling the contracts for the Polygon network and deploying them to a Polygon-compatible RPC endpoint.  Key considerations include:

* **Gas Costs:**  Gas costs on Polygon are generally lower than on Ethereum, potentially reducing transaction fees.
* **Network Compatibility:** Ensure compatibility with Polygon-specific tools and libraries.
* **Bridge Considerations:**  If existing contracts are deployed on Ethereum, a bridge mechanism might be needed to transfer tokens or data between networks.  Since this project is not yet deployed, this is not a current concern.


## Future Work

* Implement the Chainlink oracle integration.
* Implement the carbon credit gateway API.
* Merge the [mecc-token/contracts/Token.sol](https://github.com/ubuntupunk/mecc-token/contracts/Token.sol) contract into this project.
* Further define the relationship between mJ and aC token accrual.
* Refactor to Polygon network.
