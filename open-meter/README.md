# Open Metering Device Specification

## Overview

This document outlines the specifications for building a separate metering device for home producers of solar panels. The goal is to provide a cost-effective solution that can be integrated into a domestic solar power system.

## PCB Design

### Circuit Diagram

The circuit diagram for the metering device is provided below. This diagram includes all the necessary components and their connections.

<div hidden>
```
@startuml circuitDiagram

skinparam defaultTextAlignment center
skinparam linetype ortho

rectangle "Solar Panels" as SolarPanels #lightgreen
rectangle "Inverter" as Inverter #lightblue
rectangle "Open Meter" as OpenMeter #lightyellow
rectangle "ESP32" as ESP32 #lightcoral
rectangle "Camera" as Camera #lightgray
rectangle "Data Processing" as DataProcessing #lightcyan
rectangle "Chainlink Oracle" as ChainlinkOracle #lightpink
rectangle "Smart Contracts" as SmartContracts #lightorange
rectangle "Home Assistant" as HomeAssistant #lightpurple
rectangle "Internet" as Internet #lightblue

SolarPanels --> Inverter : Energy
Inverter --> OpenMeter : DC Voltage, Current
OpenMeter --> ESP32 : Analog Data
ESP32 --> Camera : Image Data
ESP32 --> DataProcessing : Processed Data
DataProcessing --> ChainlinkOracle : Data
ChainlinkOracle --> SmartContracts : Verified Data
SmartContracts --> HomeAssistant : Tokenized Energy
SmartContracts --> Internet : Data

note right of SmartContracts
  Carbon Credits (aC), Energy Tokens (mJ)
end note

note right of HomeAssistant
  Energy Consumption Monitoring
end note

note right of Internet
  Cloud Platform, Data Storage
end note

@enduml

</div>

![](circuitDiagram.svg)

### Gerber File

The Gerber file for the PCB design is provided in the `gerber` directory. This file can be used for manufacturing the PCB.

## Bill of Materials (BOM)

The following components are required to build the metering device:

| Component | Quantity | Description |
|-----------|----------|-------------|
| ESP32 Microcontroller | 1 | Microcontroller with Wi-Fi capabilities |
| Camera Module | 1 | OV2640 or similar camera module |
| Power Supply | 1 | Suitable power supply for the ESP32 and camera module |
| Voltage Sensor | 1 | ZMPT101B or similar voltage sensor module |
| Current Sensor | 1 | ACS712 or similar current sensor module |
| Resistors | 5 | 10kΩ resistors |
| Capacitors | 3 | 10µF capacitors |
| LEDs | 2 | Indicator LEDs |
| Jumper Wires | 10 | For connections |
| PCB | 1 | Custom PCB based on the provided Gerber file |

## Circuit Design

### Measuring Voltage, Amps, and Watts

The metering device will use the following components to measure voltage, amps, and watts:

1. **Voltage Sensor:** A voltage sensor module (e.g., ZMPT101B) to measure the voltage.
2. **Current Sensor:** A current sensor module (e.g., ACS712) to measure the current.
3. **Microcontroller:** The ESP32 microcontroller will read the voltage and current values from the sensors.

### Calculating Watts

Watts (power) can be calculated using the formula:
\[ \text{Watts} = \text{Voltage} \times \text{Current} \]

The ESP32 will read the voltage and current values from the sensors and calculate the watts.

### Outputting Data to LAN

The ESP32 will transmit the measured data (voltage, amps, watts) to a server via Wi-Fi. The data will be sent in JSON format:

```json
{
  "voltage": 220.0,
  "current": 1.5,
  "watts": 330.0,
  "timestamp": "2024-07-26T10:30:00"
}
```

## Ordering the PCB Manufacture Online

To order the PCB manufacture online, follow these steps:

1. **Choose a PCB Manufacturer:** Select a reputable PCB manufacturer that offers online ordering services. Some popular options include JLCPCB, PCBWay, and EasyEDA.
2. **Upload the Gerber File:** Upload the Gerber file provided in the `gerber` directory to the manufacturer's website.
3. **Select PCB Specifications:** Choose the PCB specifications such as material, thickness, and finish according to your requirements.
4. **Place the Order:** Complete the order by providing shipping and payment information.

## Conclusion

This document provides a detailed specification for building a separate metering device for home producers of solar panels. The PCB design, circuit diagram, BOM, and ordering method are included to ensure a cost-effective and efficient solution.
