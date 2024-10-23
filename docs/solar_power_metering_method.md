# Method for Metering the Output of a Domestic Solar Power System

## Overview

This document outlines a method for metering the output of a domestic solar power system, measuring the wattage and joules, and outputting the data to LAN: Home Assistant and streaming the data to a Chainlink Oracle via the Internet.

## Method

### 1. Hardware Components

- **Solar Panels:** Photovoltaic panels that convert sunlight into electricity.
- **Inverter:** Converts the DC output from the solar panels into AC for use in the home.
- **Metering Device:** A device capable of measuring the wattage and joules produced by the solar power system.
- **ESP32 Microcontroller:** An ESP32-based microcontroller with Wi-Fi capabilities for network communication.
- **Camera Module:** An OV2640 or similar camera module with sufficient resolution to capture clear images of the meter's LCD screen.
- **Power Supply:** A suitable power supply for the ESP32 and camera module.

### 2. Software Components

- **Firmware:** Custom firmware for the ESP32, written in C/C++, to control the camera, capture images, and process the extracted data. The firmware should include:
  - Camera control functions (image capture, resolution settings).
  - Image processing algorithms (image enhancement, OCR).
  - Data extraction logic (parsing the processed image to extract relevant data fields).
  - Network communication functions (sending data to a server via Wi-Fi).
- **Server-Side Application:** A server-side application (e.g., written in Python, Node.js, etc.) to receive and process the data from the ESP32. This application should handle:
  - Data reception from the ESP32.
  - Data validation and error handling.
  - Data storage and management.
  - Data forwarding to other systems (e.g., Home Assistant, Chainlink oracle).

### 3. Data Acquisition Process

1. **Image Capture:** The ESP32's camera module captures an image of the meter's LCD screen at regular intervals (e.g., every 5 minutes).
2. **Image Processing:** The captured image is processed using image enhancement techniques (e.g., noise reduction, contrast adjustment) to improve the quality of the text. Optical Character Recognition (OCR) is then used to extract the text from the image.
3. **Data Extraction:** The extracted text is parsed to identify and extract the relevant data fields (e.g., meter ID, current consumption, remaining credit).
4. **Data Transmission:** The extracted data is transmitted to the server-side application via Wi-Fi using a suitable communication protocol (e.g., MQTT, HTTP).
5. **Data Processing and Storage:** The server-side application receives, validates, and stores the data. The data is then forwarded to Home Assistant and the Chainlink oracle as needed.

### 4. Data Format

The data transmitted to the server will be in JSON format:

```json
{
  "MeterID": "1234567890",
  "Timestamp": "2024-07-26T10:30:00",
  "CurrentConsumption": 1.5,
  "TotalConsumption": 150.2,
  "RemainingCredit": 50.8,
  "ErrorCode": 0
}
```

### 5. Error Handling

The system should include robust error handling mechanisms to address potential issues such as:

- Camera errors (e.g., image capture failure).
- OCR errors (e.g., text extraction failure).
- Network communication errors (e.g., connection failure).

Error codes should be defined and transmitted along with the data.

### 6. Security Considerations

Security measures should be implemented to protect the data during transmission and storage. This may include encryption and authentication mechanisms.

### 7. Future Considerations

- Explore alternative image processing techniques for improved accuracy and robustness.
- Implement advanced error handling and recovery mechanisms.
- Investigate the use of machine learning for improved OCR accuracy.

## Schematics

### Data Acquisition Diagram

```mermaid
graph LR
    A[Solar Panels] --> B[Inverter];
    B --> C[Metering Device];
    C --> D[ESP32 + Camera];
    D --> E[Data Processing];
    E --> F{Chainlink Oracle};
    F --> G[Smart Contracts];
    G --> H[Home Assistant];
    G --> I[Internet];

    style A fill:#ccf,stroke:#333,stroke-width:2px;
    style C fill:#ccf,stroke:#333,stroke-width:2px;
    style G fill:#ccf,stroke:#333,stroke-width:2px;
    linkStyle 0,1,2,3,4,5,6,7,8 stroke:#666,stroke-width:2px;

    classDef token fill:#ccf,stroke:#333,stroke-width:2px;
    classDef nft fill:#ccf,stroke:#333,stroke-width:2px;
    classDef oracle fill:#ccf,stroke:#333,stroke-width:2px;

    class C,G token;
    class F oracle;
```

### Data Flow Diagram

```mermaid
graph TD
    A[Solar Panels] --> B[Inverter];
    B --> C[Metering Device];
    C --> D[ESP32 + Camera];
    D --> E[Data Processing];
    E --> F{Chainlink Oracle};
    F --> G[Smart Contracts];
    G --> H[Home Assistant];
    G --> I[Internet];

    style A fill:#ccf,stroke:#333,stroke-width:2px;
    style C fill:#ccf,stroke:#333,stroke-width:2px;
    style G fill:#ccf,stroke:#333,stroke-width:2px;
    linkStyle 0,1,2,3,4,5,6,7,8 stroke:#666,stroke-width:2px;

    classDef token fill:#ccf,stroke:#333,stroke-width:2px;
    classDef nft fill:#ccf,stroke:#333,stroke-width:2px;
    classDef oracle fill:#ccf,stroke:#333,stroke-width:2px;

    class C,G token;
    class F oracle;
```

## Conclusion

This document provides a high-level overview of the data acquisition method. Detailed implementation specifics will depend on the chosen hardware and software components.
