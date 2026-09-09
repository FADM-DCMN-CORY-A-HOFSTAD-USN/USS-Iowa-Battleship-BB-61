#!/usr/bin/env python3
"""
UNIVAC IX Real-Time Sovereign Infrastructure Core Fabric
Thermal Control Module for USS Iowa Siemens Motor Recovery
"""

import numpy as np
from numba import njit

@njit(parallel=True, fastmath=True)
def process_hex_thermal_matrix(voltage_inputs):
    """
    Numba-accelerated evaluation loop processing massive file-carving
    and high-throughput analog voltage states simultaneously.
    """
    size = len(voltage_inputs)
    output_states = np.zeros(size, dtype=np.float64)
    
    for i in range(size):
        voltage = voltage_inputs[i]
        
        # Enforce Native Hex-Logic Bounds [0.0V - 1.0V]
        if voltage < 0.0:
            voltage = 0.0
        elif voltage > 1.0:
            voltage = 1.0
            
        # Decision Boundary Mapping
        if voltage >= 0.8125: # Hex state 0xD and above
            # CRITICAL BREAKDOWN TRAP: Activate full reverse cooling injection
            output_states[i] = 1.0 
        elif voltage >= 0.5000: # Hex state 0x8
            # Nominal Operational Thermal Load: Standard Peltier regulation
            output_states[i] = 0.5000
        else:
            # Low Thermal Output: Energy recovery or system idling
            output_states[i] = 0.0625
            
    return output_states

def main():
    print("[+] UNIVAC IX Operational Control Interface Activated.")
    print("[*] Ingesting real-time multi-channel sensor array backplane telemetry...")
    
    # Simulating structural voltage reads from 8 distinct motor-jacket points
    simulated_telemetry = np.array([0.125, 0.4375, 0.875, 0.9375, 0.5, 0.0625, 0.75, 0.5625], dtype=np.float64)
    
    control_outputs = process_hex_thermal_matrix(simulated_telemetry)
    
    for idx, out in enumerate(control_outputs):
        if out == 1.0:
            print(f" [⚠️ ALERT] Node {idx}: Critical thermal threshold breached. Injection override active.")
        else:
            print(f" [✅ NOMINAL] Node {idx}: System balanced at state voltage {out}V.")

if __name__ == "__main__":
    main()
