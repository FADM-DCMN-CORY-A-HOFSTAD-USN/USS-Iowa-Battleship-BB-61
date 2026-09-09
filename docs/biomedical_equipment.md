OpenSCAD Model: `biochem_centrifuge_rotor.scad`

This mechanical script designs a high-speed, balanced, shock-isolated centrifuge rotor assembly. It is engineered to spin down continuous-flow units of **Verdura-Rx Whole Blood**substitutes and plasma alternatives without mechanical degradation from ship roll.

KiCad Schematic & Netlist: biochem_sensor_array.kicad_schThis layout connects a high-precision optical hemoglobin density sensor. It passes monochromatic light through a liquid flow path to screen Verdura-Rx batches for impurities before automated transfusion delivery.

UNIVAC Verification Loop: `biochem_separation_loop.hex`

This C# simulation interprets the compiled state-machine instructions stored in **`biochem_separation_loop.hex`**. It continuously checks the optical density values against automated rotor speed variables to maintain a stable blood separation line.

OpenSCAD Model: `biochem_reagent_mixer.scad`

This mechanical script designs a precision fluid-blending block machined out of solid surgical-grade alloy. It integrates specialized internal mixing baffles and dedicated recesses for the **`biochem_thermal_control`** heating arrays to keep **Verdura-Rx** flow paths precisely stabilized at target baseline values.

KiCad Schematic & Netlist: `biochem_thermal_control.kicad_sch`

This electronic schema provides the driver matrix for the heating elements within the block. It implements high-current switching transistors running on a dedicated digital loop isolated from processing lines by optoelectronic arrays.

UNIVAC State Control Loop Update: `biochem_separation_loop.hex`

This sequence handles precision temperature tracking. It processes real-time thermistor changes through registers `0x00D0`to `0x00D4`. If shipboard environmental shifts break safety bounds, the program drops the line voltage to protect the synthetic blood assets.

| Hex Address | Opcode Instruction | Target Matrix Mapping | Functional Description |
| `0x00D0` | `0x52` | **READ_THERMISTOR** | Samples analog voltage lines from NTC thermistor arrays |
| `0x00D2` | `0x9B` | **ADJUST_PWM_DUTY** | Scales duty cycle variable down to maintain stable 37°C curve |
| `0x00D4` | `0xF1` | **CRITICAL_SHUTDOWN** | Emergency isolation loop; drops heater line to neutral safe state |

* * * * *

Decoded State Machine Instruction Breakdowns

| Memory Address (Hex) | Instruction Word (Hex) | Assembly Mnemonic | Target Hardware Sub-System | Operational State Description |
| `0x0000` | `3D 96` | `SET_ROTOR_RPM 0x96` | Centrifuge Motor Core | Establishes centrifuge spin velocity at a calibrated baseline configuration (3,750 RPM). |
| `0x0002` | `B5 25` | `INCUBATOR_TEMP 0x25` | Reagent Mixing Thermal Block | Sets the PID target threshold for the heating block to hold a stable 37°C core profile. |
| `0x0004` | `82 1F` | `SAMPLE_SPECTRO 0x1F` | Hemoglobin Optical Flow Cell | Reads the current optical transmission value across the fluid lines to verify batch clarity. |
| `0x0006` | `52 AC` | `READ_THERMISTOR 0xAC` | NTC Feedback Probe | Samples the analog diagnostic return voltages to scan for thermal drift deviations. |
| `0x0008` | `9B 40` | `ADJUST_PWM 0x40` | High-Power Driver MOSFET | Modulates the duty-cycle output to balance heating elements against fluid flow rates. |
| `0x000A` | `F1 FF` | `SAFETY_OVERRIDE 0xFF` | Emergency System Shunt | Monitors structural line bounds; drops power connections if shipboard sensors report high-g shock. |
| `0x000C` | `00 00` | `HALT_SYSTEM 0x00` | Main Process Registers | Terminates execution loop safely and parks all mechanical arrays in default storage positions. |
