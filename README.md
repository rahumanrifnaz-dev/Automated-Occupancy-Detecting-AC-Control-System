# Automated Occupancy Detecting AC Control System

An automated air conditioning control system designed to reduce unnecessary
energy consumption in unoccupied rooms while protecting the AC compressor
from frequent ON/OFF cycling.

The system uses **PIR and Microwave sensors** for occupancy detection and
applies staged control logic to operate the AC in normal, Eco, and Deep
Eco/OFF modes.

> **Project status:** MATLAB/Simulink control-logic simulation and SolidWorks
> mechanical design completed. Physical hardware implementation and real-time
> field testing are planned as future work.

---

## Table of Contents

- [Project Overview](#project-overview)
- [Problem Statement](#problem-statement)
- [Objectives](#objectives)
- [System Concept](#system-concept)
- [System Architecture](#system-architecture)
- [Occupancy Detection](#occupancy-detection)
- [Control Logic](#control-logic)
- [MATLAB and Simulink Simulation](#matlab-and-simulink-simulation)
- [SolidWorks Mechanical Design](#solidworks-mechanical-design)
- [Key Features](#key-features)
- [Project Workflow](#project-workflow)
- [Repository Structure](#repository-structure)
- [Technologies Used](#technologies-used)
- [Project Team](#project-team)
- [Current Status](#current-status)
- [Future Improvements](#future-improvements)
- [References](#references)
- [License](#license)

---

## Project Overview

Leaving air conditioners running in unoccupied rooms results in
unnecessary electricity consumption, increased operating costs, environmental
impact, and additional stress on AC components.

This project proposes an **Automated Occupancy Detecting AC Control System**
that automatically changes the operating mode of a split-type AC according to
the detected occupancy condition and duration of absence.

The system combines **PIR and Microwave sensors** using a sensor-fusion
approach to improve occupancy detection compared with relying on a single
motion sensor.

---

## Problem Statement

Conventional split-type AC units generally require users to manually control
their operation. When occupants leave a room without switching the AC off,
the unit can continue cooling an empty space.

A simple motion-based ON/OFF system can also introduce another problem:
**frequent switching or short cycling**, which can increase stress and wear on
the compressor.

Therefore, the system needs to:

1. Detect whether the room is occupied.
2. Distinguish short-term absence from long-term absence.
3. Reduce unnecessary energy consumption.
4. Avoid unnecessary rapid ON/OFF switching.
5. Maintain user comfort during short periods of inactivity.

---

## Objectives

The main objectives of the project are:

- Develop an occupancy detection system using PIR and Microwave sensors.
- Improve occupancy detection using sensor fusion.
- Develop staged AC control logic based on absence duration.
- Introduce an Eco mode for short-term absence.
- Introduce Deep Eco/OFF control for long-term absence.
- Reduce unnecessary energy consumption.
- Reduce compressor stress caused by frequent switching.
- Develop and validate the control logic using MATLAB and Simulink.
- Design a practical enclosure for the system using SolidWorks.

---

## System Concept

The system continuously monitors occupancy using two sensor types:

```text
              ┌─────────────────┐
              │   PIR Sensor    │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ Sensor Fusion   │
              │     Logic       │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ Occupancy /     │
              │ Absence Logic   │
              └────────┬────────┘
                       │
                       ▼
              ┌─────────────────┐
              │ Timers & Control│
              │     Logic       │
              └────────┬────────┘
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
       Normal        Eco       Deep Eco/OFF
          │            │            │
          └────────────┼────────────┘
                       ▼
              ┌─────────────────┐
              │   AC Control    │
              └─────────────────┘
```

The control system uses occupancy duration rather than immediately turning
the AC off whenever motion stops.

---

## System Architecture

The major components of the proposed system are:

- PIR occupancy sensor
- Microwave occupancy sensor
- IoT-based control unit
- Timer / absence detection logic
- AC control interface
- Optional on-screen display
- Optional QR-code-based manual override
- SolidWorks-designed mechanical enclosure

### Main Control Path

```text
PIR Sensor ───────┐
                  ├──> Occupancy Detection
Microwave Sensor ─┘
                         │
                         ▼
                   Absence Timers
                         │
              ┌──────────┼──────────┐
              ▼          ▼          ▼
           Normal       Eco      Deep Eco/OFF
              │          │          │
              └──────────┼──────────┘
                         ▼
                      AC Unit
```

---

## Occupancy Detection

### PIR Sensor

The PIR sensor detects changes in infrared radiation associated with human
movement.

### Microwave Sensor

The Microwave sensor detects motion by transmitting microwave signals and
measuring their reflections.

### Sensor Fusion

The two sensor outputs are combined to improve detection reliability and
reduce false decisions associated with using a single sensor.

The design is intended to provide better support for cases where an occupant
may remain stationary.

---

## Control Logic

The control algorithm continuously monitors occupancy.

### Normal Mode

When occupancy is detected:

```text
Occupancy detected
       ↓
   Normal Mode
       ↓
   AC operates normally
```

### Eco Mode

When no occupancy is detected for approximately **15 minutes**, the system
changes the AC to **Standby/Eco mode**.

```text
No occupancy
     ↓
15 minutes
     ↓
Eco Mode
```

The proposed Eco mode raises the temperature setpoint by approximately
2–3 °C and reduces compressor operation while maintaining comfort.

### Deep Eco / OFF Mode

When the room remains unoccupied for more than **60 minutes**, the system
switches the AC to Deep Eco mode or turns it off completely, depending on
the AC capability.

```text
No occupancy
     ↓
60 minutes
     ↓
Deep Eco / OFF
```

### Timer Reset

When occupancy is detected again, the absence timers reset to zero.

This ensures that the Eco or shutdown conditions are based on a continuous
period of vacancy rather than accumulated disconnected periods.

---

## MATLAB and Simulink Simulation

MATLAB and Simulink were used to model and validate the control logic.

The simulation represents occupancy using a binary signal:

```text
1 → Occupied
0 → Unoccupied
```

### Time Scaling

To make long-duration testing practical, the simulation uses time scaling:

```text
1 second of simulation = 1 minute of real-world operation
```

Therefore:

```text
150 seconds of simulation
        =
150 minutes of represented operation
        =
2.5 hours
```

This allows both the approximately 15-minute Eco trigger and 60-minute
Deep Eco/OFF trigger to be tested within a short simulation.

### Simulation Logic

The Simulink model contains:

- PIR sensor input
- Microwave sensor input
- Sensor combination logic
- Short-absence timer
- Long-absence timer
- Eco-mode control
- Shutdown control
- Manual override
- AC operating-state outputs

The absence timers are implemented using discrete-time integrator blocks.
When occupancy is detected, the timer inputs change and the accumulated
absence time is reset.

---

## SolidWorks Mechanical Design

A mechanical enclosure was designed using **SolidWorks**.

The enclosure consists of:

1. Main control box
2. Dedicated sensor unit
3. Mounting brackets

### Design Considerations

- Sensor visibility and detection coverage
- Protection of electronic components
- Practical installation
- Internal airflow
- Ventilation slots
- Front display cutout
- Elevated sensor position

The PIR and Microwave sensors are positioned in a separate upper unit to
provide a better field of view across the room.

---

## Key Features

| Feature | Description |
|---|---|
| Automatic operation | Reduces dependence on manual AC control |
| Sensor fusion | Combines PIR and Microwave sensor information |
| Eco mode | Reduces AC operation during short absences |
| Deep Eco/OFF | Provides greater energy saving during long absences |
| Timer-based control | Prevents immediate AC shutdown |
| Anti-short-cycling logic | Reduces unnecessary rapid ON/OFF switching |
| Manual override | Allows user intervention |
| Optional display | Can show occupancy and AC status |
| Scalable design | Can be extended to offices, classrooms and smart buildings |

---

## Project Workflow

```text
Problem Identification
        ↓
System Concept Development
        ↓
Occupancy Detection Strategy
        ↓
MATLAB / Simulink Modeling
        ↓
Control Logic Simulation
        ↓
Simulation Validation
        ↓
SolidWorks Enclosure Design
        ↓
Technical Report
        ↓
Future Hardware Implementation
        ↓
Real-Time / Field Validation
```

---

## Repository Structure

```text
Automated-Occupancy-Detecting-AC-Control-System/
│
├── README.md
│
├── docs/
│   ├── Project_Report.pdf
│   └── Project_Paper.pdf
│
├── matlab/
│   ├── sensor_simulation.m
│   ├── occupancy_simulation.m
│   └── README.md
│
├── simulink/
│   ├── AC_Control_System.slx
│   ├── Short_Absence_Timer.slx
│   ├── Long_Absence_Timer.slx
│   └── README.md
│
├── solidworks/
│   ├── enclosure/
│   │   ├── Main_Control_Box.*
│   │   ├── Sensor_Unit.*
│   │   └── Mounting_Bracket.*
│   │
│   ├── assembly/
│   │   └── AC_Control_System_Assembly.*
│   │
│   └── README.md
│
├── results/
│   ├── simulation/
│   ├── figures/
│   └── README.md
│
├── images/
│   ├── system-overview.png
│   ├── control-flowchart.png
│   ├── simulink-model.png
│   ├── timer-subsystems.png
│   └── solidworks-enclosure.png
│
├── references/
│   └── references.md
│
└── LICENSE
```

> `*` represents the actual SolidWorks file extension(s) used by the project.

---

## Technologies Used

### Simulation & Modeling

- MATLAB
- Simulink

### Mechanical Design

- SolidWorks

### Proposed Control Hardware

- ESP32-based IoT controller
- PIR sensor
- Microwave sensor
- AC control interface

### Documentation

- LaTeX / Overleaf
- IEEE-style technical documentation

---

## Project Team

| Name | Student ID | Main Contribution |
|---|---|---|
| R. R. P. Rashmika | 230538L | LaTeX technical report and documentation |
| K. R. M. Rifnaz | 230550P | SolidWorks enclosure design and project report |
| B. K. G. S. Rodrigo | 230551U | MATLAB and Simulink simulation |

All team members also contributed to project discussions and final
preparation.

---

## Current Status

### Completed

- [x] Problem identification
- [x] System concept development
- [x] PIR + Microwave occupancy detection concept
- [x] Staged Eco-mode control logic
- [x] MATLAB simulation
- [x] Simulink control model
- [x] Simulation validation
- [x] SolidWorks enclosure design
- [x] Technical report

### Planned

- [ ] Physical prototype implementation
- [ ] Sensor hardware integration
- [ ] AC interface implementation
- [ ] Real-time hardware testing
- [ ] Test-room installation
- [ ] Electricity consumption comparison
- [ ] User feedback collection
- [ ] Long-term reliability testing

---

## Future Improvements

The project can be extended in several directions:

- Advanced occupancy sensors
- Camera-based occupancy detection
- CO₂-based occupancy detection
- Occupancy data storage
- IoT-based remote monitoring
- Mobile application integration
- AI / machine-learning-based user-pattern analysis
- Real-time hardware testing
- Long-term field validation
- Expansion to offices, classrooms and commercial buildings

These improvements are intended to increase the intelligence, efficiency and
practical applicability of the system.

---

## References

The project report and technical paper used the following major references:

1. **HVAC Control System with Occupancy Detection**, US Patent
   Application US20220214230A1.
2. W. Song et al., *Impact of occupancy behavior on building energy
   efficiency*, Energy and Buildings, 2025.
3. M. Siriwardhana, *Comparison of energy consumption between a standard and
   an inverter AC*, SLEMA Journal / Sri Lankan Engineering Journal.
4. Texas Instruments, *Occupancy Detection Using Passive Infrared-Based
   Technology*, Application Note SLLA603, 2023.
5. K. Gunasekara et al., *Sustainable hybrid cooling in tropical climates*,
   Buildings, 2025.
6. University of Moratuwa, *Developing evaluation criteria for assessing the
   performance of smart retrofitting of existing buildings in Sri Lanka*,
   Technical Report, 2025.
7. A. García-Marín et al., *An experimental comparative study of energy
   saving based on occupancy control strategies*, Building and Environment,
   2025.
8. X. Li et al., *Long-term field testing of the accuracy and HVAC energy
   savings of occupancy-centric smart thermostats*, Energy and Buildings,
   2025.

---

## License

This repository contains academic project work developed by students of the
Department of Electrical Engineering, University of Moratuwa.

Unless otherwise specified, the project materials are intended for academic
and educational purposes.
