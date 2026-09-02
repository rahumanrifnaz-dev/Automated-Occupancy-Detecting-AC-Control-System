# MATLAB Simulation

This folder contains MATLAB material for validating the occupancy-based AC control logic described in the project report and technical paper.

## Included file

- `occupancy_control_simulation.m` — a self-contained reference simulation based on the documented logic. It uses a 150-minute represented window, a 15-minute Eco threshold, a 60-minute Deep Eco/OFF threshold, timer reset on renewed occupancy, and example PIR + Microwave sensor inputs.

## Documented simulation assumptions

- Occupancy is represented using binary sensor signals (`1 = occupied/detected`, `0 = no detection`).
- The project simulation uses time scaling where **1 simulation second represents 1 real-world minute**.
- After approximately **15 minutes** of continuous vacancy, the AC enters **Eco/Standby mode**.
- After **60 minutes** of continuous vacancy, the AC enters **Deep Eco mode or OFF**.
- When occupancy is detected again, the absence timer resets.

## Important note

The original report describes MATLAB code and a Simulink implementation but the source ZIP does not contain the original `.m` or `.slx` model files. The included MATLAB script is therefore a **reproducible reference implementation derived from the documented behavior**, not a claim that it is the exact original source.

## Run

Open MATLAB, change the current folder to `matlab/`, and run:

```matlab
occupancy_control_simulation
```

The script prints state transitions and produces plots for sensor inputs, fused occupancy, and AC operating mode.
