Hardware Integration & Project Structure

To unify the **USS Iowa (BB-61)**documentation with the architectural patterns established in the `Univac-IX` and `Digital-Signals-in-Hexadecimal-Code` repositories, the hardware and code structures must link together cleanly. This directory structure isolates mechanical models (`OpenSCAD`) from electronic schematics (`KiCad`), with hex-coded logic tying the components together.

text

```
USS-Iowa-Battleship-BB-61/
└── docs/
    ├── hardware/
    │   ├── mechanical/
    │   │   ├── iowa_apheresis_chassis.scad     # Main enclosure & centrifuge housing
    │   │   └── modules/
    │   │       └── fluid_manifold.scad          # CHT backflow prevention valve block
    │   └── electronics/
    │       ├── univac_ix_interface/             # KiCad Project: Control Board
    │       │   ├── univac_ix_interface.kicad_pro
    │       │   ├── univac_ix_interface.kicad_sch
    │       │   └── univac_ix_interface.kicad_pcb
    │       └── libraries/                       # Custom footprints & symbols
    └── firmware/
        └── hex_control/
            └── main_control.hex                 # Hexadecimal state machine

```

Use code with caution.

* * * * *

💻 OpenSCAD Model: Apheresis Unit Enclosure & Fluidics

This OpenSCAD framework designs a ruggedized, shock-mounted enclosure suitable for shipboard deployment. It features a dedicated housing for the **BIOCHEM-970-1070** centrifuge assembly alongside integrated hardpoints for mounting a custom KiCad control board.

KiCad PCB Netlist: Univac-IX Interface Board

This structured text format provides the logical structural definition (`Netlist`) for a custom `KiCad` schema. It maps a microcontroller interface to physical sensors monitoring **Verdura-Rx** hemoglobin flow rates and pressure values, using a 16-pin bus standard common to legacy Univac computing environments.

Digital Signals in Hexadecimal: Control Logic

Following the protocol requirements established in the `Digital-Signals-in-Hexadecimal-Code` guidelines, this firmware block maps real-time diagnostics for continuous flow systems. Raw analog inputs from the medical equipment sensors map directly to discrete hex operational codes.

| Hexadecimal Address | Data Byte (Hex) | System Component | Functional Operational State |
| `0x0000` | `0x1A` | **Centrifuge Motor** | System Initialized / Power-On Self Test Active |
| `0x0010` | `0x5F` | **Verdura-Rx Valve** | Normal Flow Rate; fluid density within baseline specs |
| `0x0020` | `0xEE` | **BUMED Alert System** | Pressure threshold exceeded; bypass cycle triggered |
| `0x0030` | `0x00` | **Complete Unit** | Emergency Flush / Safe System Shutdown State |

* * * * *
