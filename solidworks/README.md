# SolidWorks Mechanical Design

The project uses a SolidWorks-designed enclosure for the occupancy-detecting AC controller. The original native SolidWorks files are **not present in this repository ZIP**, so this folder records the documented mechanical design and provides the expected storage layout for the real CAD files when available.

## Documented assembly

The enclosure is described as a practical three-part arrangement:

- **Main control box** — houses control electronics and includes side ventilation slots.
- **Dedicated sensor unit** — mounted above the main box to improve the PIR and Microwave sensors' field of view.
- **Mounting brackets** — support installation of the device.

The main enclosure also includes a front cutout for a display. The design was virtually assembled to verify fit before physical implementation.

## Design priorities

- Good occupancy-sensor field of view
- Protection of electronics
- Ventilation / airflow
- Practical installation
- Display integration
- Sensor positioning away from unsuitable locations such as direct AC airflow

## Folder layout

```text
solidworks/
├── enclosure/     # part files for main box, sensor unit, brackets, drawings
├── assembly/      # assembly file(s)
└── README.md
```

Add only genuine project CAD files (`.SLDPRT`, `.SLDASM`, `.SLDDRW`, STEP/STL exports, etc.) when available. The repository currently keeps these folders with `.gitkeep` files so the structure is preserved.
