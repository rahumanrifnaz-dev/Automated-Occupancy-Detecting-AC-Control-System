# Simulink Model Documentation

The project report and technical paper describe a Simulink model used to validate an occupancy-based AC controller. The original `.slx` model is **not present in this repository ZIP**, so this folder documents the model architecture and the files that should be added when the original model is available.

## Documented model blocks / functions

The model contains or represents the following logic:

1. **PIR sensor input**
2. **Microwave sensor input**
3. **Combined occupancy decision**
4. **Short-absence timer**
5. **Long-absence timer**
6. **Eco-mode output**
7. **Shutdown / Deep-Eco output**
8. **Manual override**
9. **Status outputs / displays**

The technical paper states that the absence timers are implemented using **discrete-time integrator blocks**. When occupancy is detected, the timers reset so that Eco or shutdown is triggered only after a continuous period of vacancy.

## Control thresholds

| Condition | AC action |
|---|---|
| Occupancy detected | Normal operation |
| No occupancy for ~15 min | Eco / Standby |
| No occupancy for >=60 min | Deep Eco / OFF |
| Occupancy returns | Reset absence timer and resume normal logic |

The documented simulation scales time so that **1 second of simulation represents 1 minute of real-world operation**. A 150-second simulation therefore represents 150 minutes.

## Manual override

The paper describes a manual override path that can force the system state independently of sensor outputs. It also discusses a QR-code-based user override as a future/user-interface option.

## Suggested files to add later

When the original Simulink source is recovered, add it here, for example:

```text
simulink/
├── AC_Control_System.slx
├── Short_Absence_Timer.slx      # only if stored as a separate model
├── Long_Absence_Timer.slx       # only if stored as a separate model
└── README.md
```

Do not create placeholder `.slx` files; commit the real exported models only.
