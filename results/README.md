# Results and Validation

This directory is intended for simulation outputs, figures, screenshots, and later hardware-validation results.

## What the documents report

The project documents state that:

- Occupancy detection using combined PIR and Microwave inputs was validated conceptually/in simulation.
- The AC control logic switches between **Normal**, **Eco**, and **Deep Eco/OFF** according to vacancy duration.
- The simulation uses approximately **15 minutes** of vacancy for Eco mode and **60 minutes** for Deep Eco/OFF.
- Timer reset behavior is used to avoid triggering an energy-saving state from disconnected short absences.
- Real-time hardware testing was not completed because of limited hardware access and remains future work.

## Folders

- `figures/` — plots and screenshots suitable for the README/report.
- `simulation/` — exported simulation data, logs, tables, or MAT/CSV outputs.

## Suggested GitHub evidence to add

When available, add:

1. Simulink model screenshot.
2. Short- and long-absence timer subsystem screenshots.
3. MATLAB occupancy/control-state plot.
4. SolidWorks enclosure render/front/side views.
5. Hardware prototype photographs.
6. Measured energy-consumption comparison from field testing.

Do not present future hardware results as completed until measurements are actually collected.
