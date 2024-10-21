:::mermaid

graph LR
    A[Prepaid Electricity Meter] --> B(ESP32 Microcontroller);
    B --> C{Image Processing & Data Extraction};
    C --> D[JSON Data];
    D --> E[Wi-Fi];
    E --> F[LAN Network];
    F --> G[Home Assistant];
    F --> H[Oracle Gateway];
    H --> I[Chainlink Oracle];

    subgraph "Data Acquisition System"
        A; B; C; D; E;
    end

    subgraph "Data Integration"
        F; G; H; I;
    end

    style A fill:#f9f,stroke:#333,stroke-width:2px
    style I fill:#ccf,stroke:#333,stroke-width:2px
    linkStyle 0,1,2,3,4,5,6,7 stroke:#666,stroke-width:2px
:::