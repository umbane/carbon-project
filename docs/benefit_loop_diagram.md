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