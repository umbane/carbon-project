# ESP32 Firmware for Solar Power Metering

## Overview

This repository contains the firmware for the ESP32 microcontroller used in the solar power metering system. The firmware is designed to capture images of the meter's LCD screen, process the data, and transmit it to a server via Wi-Fi.

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

## Data Acquisition Process

1. **Image Capture:** The ESP32's camera module captures an image of the meter's LCD screen at regular intervals (e.g., every 5 minutes).
2. **Image Processing:** The captured image is processed using image enhancement techniques (e.g., noise reduction, contrast adjustment) to improve the quality of the text. Optical Character Recognition (OCR) is then used to extract the text from the image.
3. **Data Extraction:** The extracted text is parsed to identify and extract the relevant data fields (e.g., meter ID, current consumption, remaining credit).
4. **Data Transmission:** The extracted data is transmitted to the server-side application via Wi-Fi using a suitable communication protocol (e.g., MQTT, HTTP).
5. **Data Processing and Storage:** The server-side application receives, validates, and stores the data. The data is then forwarded to Home Assistant and the Chainlink oracle as needed.

## Data Format

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

## Error Handling

The system should include robust error handling mechanisms to address potential issues such as:

- Camera errors (e.g., image capture failure).
- OCR errors (e.g., text extraction failure).
- Network communication errors (e.g., connection failure).

Error codes should be defined and transmitted along with the data.

## Security Considerations

Security measures should be implemented to protect the data during transmission and storage. This may include encryption and authentication mechanisms.

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
