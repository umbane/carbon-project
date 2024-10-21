# Carbon Credits and Energy System

This project integrates a carbon credit system with an energy token system.  The core contracts are detailed in [docs/README.md](docs/README.md), including `carboncredits.sol`, `credittoken.sol`, `certification.sol`, `token.sol`, `integration/IntegrationContract.sol`, and `pledge.sol`.  A key feature of this system is the issuance of carbon credits (aC) as NFTs, providing enhanced security and transparency.

# Rationale

Currently City of Cape Town (CoCT) electricity users may feed electricity into the grid in exchange for a modest credit on the network. This is all good and well, but it creates a vertical monopoly where consumers/producers i.e. *prosumers* are prevented from sharing energy and/or surplus credits directly with their neighbours and the community at large. In addition, only feed-in energy is rewarded. 

We propose the addition of a blockchain token (mJ) which is minted whenever there is "proof of production" of one watt of domestic energy, the mJ can then be traded for a carbon credit (aC) via an API to the JSE carbon trading desk or other carbon trading projects.

Benefits include reward of domestic production irrespective of the feed-in tariff, and ability to store tokens for future economic advantage. See our [white paper](https://github.com/Muizenberg-Electricity-Cooperative/Carbon-Project/blob/main/docs/white-paper.md)
## Project Structure

* **`carboncredits.sol`:** Core contract for managing carbon credit holders, verifiers, and customers.
* **`credittoken.sol`:** ERC20 token contract for carbon credits, inheriting from `carboncredits.sol`.
* **`certification.sol`:** Contract for a specific certification standard (e.g., Gold Standard), inheriting from `credittoken.sol`.
* **`integration/IntegrationContract.sol`:** Contract integrating the carbon credit system with the energy token system.
* **`token.sol`:** Contract for energy (mJ) and carbon credit (aC) tokens.  This contract now supports the issuance of aC tokens as NFTs.
* **`pledge.sol`:** Contract for pledging mJ and/or aC tokens to generate CarB tokens.
* **`docs/README.md`:** Detailed documentation for all contracts.
* **`docs/chainlink_integration.md`:** Documentation for Chainlink oracle integration.
* **`docs/system_diagram.md`:** Mermaid diagram visualizing the contract system.
* **`docs/electricity_meter_data_spec.md`:** Specification for electricity meter data output port.
* **`docs/white-paper.md`:** MECC White Paper

## Integration Details

The `IntegrationContract.sol` facilitates the interaction between the carbon credit system and the energy token system.  It allows for the accrual of aC tokens based on carbon credit issuance and potentially mJ token usage (requires further implementation).  

A `Chainlink oracle` is planned for verifying energy usage data and minting mJ tokens.

A `Data Output Port specification` ([docs/electricity_meter_data_spec.md](docs/electricity_meter_data_spec.md)) is proposed to facilitate data acquisition for the Chainlink oracle.

A [method of scraping data from the current metering system](docs/prepaid_meter_data_acquisition.md) utilising ESP32 & MPEG is also proposed.

## Polygon Network Refactoring

Refactoring this project to the Polygon network involved recompiling the [contracts for the Polygon network](polygon-contracts/) and will require deployment to a Polygon-compatible RPC endpoint.  Key considerations include:

* **Gas Costs:**  Gas costs on Polygon are generally lower than on Ethereum, potentially reducing transaction fees.
* **Network Compatibility:** Ensure compatibility with Polygon-specific tools and libraries.
* **Bridge Considerations:**  If any existing contracts are deployed on Ethereum, a bridge mechanism might be needed to transfer tokens or data between networks.  Since this project is not yet deployed, this is not a current concern.

## Diagram of our System
You can view a [mermaid diagram of our system here](docs/benefit_loop_diagram.md), alongside other diagrams in our [schematics folder](docs/schematics/).

``` mermaid
%%{
  init: {
    'theme': 'base',
    'themeVariables': {
      'primaryColor': '#BB2528',
      'primaryTextColor': '#fff',
      'primaryBorderColor': '#7C0000',
      'lineColor': '#F8B229',
      'secondaryColor': '#006100',
      'tertiaryColor': '#fff'
    }
  }
}%%

graph LR
    subgraph "Data Acquisition"
        A[Prepaid Meter Data Port] --> B(Data Acquisition System);
        C[Prepaid Meter No Data Port] --> D(ESP32 + Camera);
        D --> B;
        B --> E(Data Processing);
        Z[Domestic Electricity Production] --> B;
    end

    subgraph "Domestic Energy Production"
        Z --> Y[Home Solar Array];
        Z --> X[Home Wind Gen];
        Z --> W[Micro-grid];
        Z --> V[Community Owned Projects];
    end

    E --> F{Chainlink Oracle};
    F --> G[Smart Contracts];

    subgraph "Smart Contracts"
        G --> H[Token Contract MJ, aC];
        G --> I[Pledge Contract CarB];
        H --> J[Certification Contract NFTs];
    end

    subgraph "Token System"
        H; I; J;
        J --> K[User Wallet MetaMask/Phantom];
        I --> L[Community Projects];
        H --> O[Energy Bank];
    end

    subgraph "Carbon Market Integration"
        aC --> M[JSE Carbon Trading Desk];
        aC --> N[Other Carbon Platforms];
    end

    style A fill:#ccf,stroke:#333,stroke-width:2px;
    style J fill:#ccf,stroke:#333,stroke-width:2px;
    style G fill:#ccf,stroke:#333,stroke-width:2px;
    linkStyle 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17 stroke:#666,stroke-width:2px;

    classDef token fill:#ccf,stroke:#333,stroke-width:2px;
    classDef nft fill:#ccf,stroke:#333,stroke-width:2px;
    classDef oracle fill:#ccf,stroke:#333,stroke-width:2px;

    class H,J token;
    class F oracle;

  linkStyle 0,1,2,3,4,5,6,7,8 stroke:#666,stroke-width:2px
    style A fill:#ccf,stroke:#333,stroke-width:2px
    style J fill:#ccf,stroke:#333,stroke-width:2px
    style G fill:#ccf,stroke:#333,stroke-width:2px
```

## Future Work

* Implement the Chainlink oracle integration.
* Implement the carbon credit gateway API.
* Further define the relationship between mJ and aC token accrual.
* Thorough testing and modeling to assess viability.
* Further define pledge system.
* Implementation of a verification system.
* Explore autobidding & time-of-use windows.
