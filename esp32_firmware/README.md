# ESP32 Firmware for Solar Power Metering

## Overview

This repository contains the firmware for the ESP32 microcontroller used in the solar power metering system. The firmware is designed to capture images of the meter's LCD screen, process the data, and transmit it to a server via Wi-Fi. In addition, it includes a voltage and current sensor module to measure the voltage and current. This provides a backup for the data captured by the camera. It also allows the addition of a seperate pcb for the voltage and current sensor, since not all current will necessarily be metered by the City Power. Users can independently measure the voltage and current, and the data will be transmitted to the server.

> **Note"** This firmware is primarly designed to work with the ESP32 microcontroller and the OV2640 camera module. Supporting the secondary measurement circuit of the actual production of home solar power has yet to be implemented. It is also not currently able to provide verification of the data thus accumulated. We are exploring alternative methods of gaining community verification of the data via some form of honest broker that would audit the system capacity to ensure that the data is accurate, and that the data is not tampered with. If you have any ideas, please feel free to engage.

## Hardware Components

- **ESP32 Microcontroller:** An ESP32-based microcontroller with Wi-Fi capabilities for network communication.
- **Camera Module:** An OV2640 or similar camera module with sufficient resolution to capture clear images of the meter's LCD screen.
- **Power Supply:** A suitable power supply for the ESP32 and camera module.
- **Voltage Sensor:** A voltage sensor module (e.g., ZMPT101B) to measure the voltage.
- **Current Sensor:** A current sensor module (e.g., ACS712) to measure the current.

## Software Components

- **Firmware:** Custom firmware for the ESP32, written in C/C++, to control the camera, capture images, and process the extracted data. The firmware includes:
  - Camera control functions (image capture, resolution settings).
  - Image processing algorithms (image enhancement, OCR).
  - Data extraction logic (parsing the processed image to extract relevant data fields).
  - Network communication functions (sending data to a server via Wi-Fi).

## Primary Data Acquisition Process

1. **Image Capture:** The ESP32's camera module captures an image of the meter's LCD screen at regular intervals (e.g., every 5 minutes).
2. **Image Processing:** The captured image is processed using image enhancement techniques (e.g., noise reduction, contrast adjustment) to improve the quality of the text. Optical Character Recognition (OCR) is then used to extract the text from the image.
3. **Data Extraction:** The extracted text is parsed to identify and extract the relevant data fields (e.g., meter ID, current consumption, remaining credit).
4. **Data Transmission:** The extracted data is transmitted to the server-side application via Wi-Fi using a suitable communication protocol (e.g., MQTT, HTTP).
5. **Data Processing and Storage:** The server-side application receives, validates, and stores the data. The data is then forwarded to Home Assistant and the Chainlink oracle as needed.

## Secondary Data Acquisition Process

1. **Voltage and Current Measurement:** The voltage and current sensors measure the voltage and current in the solar power system.
2. **Data Transmission:** The measured voltage and current data is transmitted to the server-side application via Wi-Fi using a suitable communication protocol (e.g., MQTT, HTTP).
3. **Data Processing and Storage:** The server-side application receives, validates, and stores the data. The data is then forwarded to Home Assistant and the Chainlink oracle as needed.


## Data Format for Primary Data Acquisition

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

## Data Format for Secondary Data Acquisition

```json
{
  "Voltage": 220.5,
  "Current": 10.2,
  "Timestamp": "2024-07-26T10:30:00",
  "ErrorCode": 0
} 
```


## Error Handling

The system should include robust error handling mechanisms to address potential issues such as:

- Camera errors (e.g., image capture failure).
- OCR errors (e.g., text extraction failure).
- Network communication errors (e.g., connection failure).
- Data transmission errors.
- Sensor Error

Error codes should be defined and transmitted along with the data.

## Security Considerations

Security measures should be implemented to protect the data during transmission and storage. This may include encryption and authentication mechanisms.

> **Note:** Will our ESP32 be used to encrypt data or will this be done via edge-hosted services, for example a Home Assistant device that is connected to the ESP32?

## Testing and Validation

The system should undergo thorough testing and validation to ensure its accuracy and reliability. This includes testing the image processing algorithms, data extraction logic, and network communication.
## Deployment

Deploy the ESP32-based meter reading system to the solar power system. Ensure that the system is properly configured and connected to the necessary hardware components.

## Future Considerations

- Explore alternative image processing techniques for improved accuracy and robustness.
- Implement advanced error handling and recovery mechanisms.
- Investigate the use of machine learning for improved OCR accuracy.

## Uploading the Firmware

To upload the firmware to the ESP32, follow these steps:

1. **Install the Arduino IDE:** Download and install the Arduino IDE from the official website.
2. **Install the ESP32 Board Package:** Open the Arduino IDE and go to `File > Preferences`. In the "Additional Boards Manager URLs" field, add the following URL: `https://dl.espressif.com/dl/package_esp32_index.json`. Then, go to `Tools > Board > Boards Manager`, search for "esp32", and install the ESP32 board package.
3. **Open the Firmware Code:** Open the `main.cpp` file in the Arduino IDE.
4. **Select the Board and Port:** Go to `Tools > Board` and select the appropriate ESP32 board. Then, go to `Tools > Port` and select the appropriate COM port.
5. **Upload the Firmware:** Click the "Upload" button in the Arduino IDE to upload the firmware to the ESP32.

## Conclusion

This document provides a high-level overview of the firmware for the ESP32 microcontroller used in the solar power metering system. Detailed implementation specifics will depend on the chosen hardware and software components.
