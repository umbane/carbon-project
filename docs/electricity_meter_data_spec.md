# Specification for Prepaid Electricity Meter Data Output Port (South Africa - SABS Compliant)

This document specifies the data output format for a common prepaid electricity meter used in South Africa, adhering to relevant SABS (South African Bureau of Standards) standards. The specification focuses on the data output port, detailing the communication protocol, data structure, and error handling. Specific SABS standards referenced should be included here based on the relevant regulations.

## 1. Introduction

This specification defines the interface for retrieving consumption and credit data from a prepaid electricity meter. The goal is to provide a standardized and reliable method for accessing meter data for various applications, including billing systems, remote monitoring, and integration with smart home systems such as Home Assistant and Chainlink oracles.

## 2. Communication Protocol Options

The meter will support multiple communication protocols to facilitate diverse integration needs:

**2.1. Serial Communication (for local, direct connection):**

The data output port will utilize [Specify Protocol, e.g., RS-485, Modbus RTU, etc.]. This protocol is chosen for its [Explain reasons for protocol choice, e.g., robustness, reliability, cost-effectiveness, etc.]. The communication parameters will be:

*   **Baud Rate:** [Specify Baud Rate, e.g., 9600 bps]
*   **Data Bits:** [Specify Data Bits, e.g., 8]
*   **Parity:** [Specify Parity, e.g., None]
*   **Stop Bits:** [Specify Stop Bits, e.g., 1]
*   **Flow Control:** [Specify Flow Control, e.g., None]

**2.2. Network Communication (for remote access via LAN):**

To enable data transfer to Home Assistant and Chainlink oracles, the meter will include a network interface supporting:

*   **Protocol:** TCP/IP
*   **Interface:** Ethernet (wired LAN) or Wi-Fi (wireless LAN)
*   **IP Address:**  The meter will be assigned a static IP address within the LAN subnet: [Specify IP Address Range, e.g., 192.168.1.XXX]
*   **Port:** [Specify Port Number, e.g., 5000]
*   **Data Format:** JSON (JavaScript Object Notation) -  A sample JSON structure is provided below:

**Sample JSON Data Structure:**

```json
{
  "MeterID": "1234567890",
  "Timestamp": "2024-07-26T10:30:00",
  "CurrentConsumption": 1.5,
  "TotalConsumption": 150.2,
  "RemainingCredit": 50.8,
  "Voltage": 230,
  "Current": 5,
  "PowerFactor": 0.95,
  "ErrorCode": 0
}
```

## 3. Data Structure

The data structure will vary depending on the chosen communication protocol (see Section 2).  The sample structures provided in Section 2.1 and 2.2 illustrate the expected formats for serial and network communication, respectively.

## 4. Error Handling

The meter will indicate errors using an `ErrorCode` field (see Section 2 for specific error handling within each protocol).  A table defining the error codes and their meanings should be included here.  For example:

| Error Code | Description                                      |
|------------|--------------------------------------------------|
| 0          | No error                                         |
| 1          | Communication error                              |
| 2          | Sensor error                                     |
| 3          | Internal error                                   |
| ...        | ...                                             |


## 5. Security Considerations

[Describe security measures implemented to protect the data output port, e.g., authentication, encryption, etc.  Consider security implications of network access.]

## 6. Future Considerations

[Describe potential future enhancements or modifications to the specification.]


This specification is subject to change based on further developments and regulatory updates. Always refer to the latest version of this document.
