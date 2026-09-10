#!/usr/bin/env python3
# =========================================================================
# ENTERPRISE ARCHITECTURE INTEGRATION STANDARD - LEGACY MAINFRAME INTERFACE
# FILE: hex_native_univac_translator.py (Air Velocity Diagnostics Block)
# =========================================================================

import time
import math

class UnivacAirDiagnostics:
    def __init__(self):
        # Target nominal airflow standard: 400 FPM (Feet Per Minute)
        self.target_fpm = 400.0
        print("[UNIVAC-IX] Legacy 36-Bit Diagnostic Protocol Driver Engaged.")

    def downconvert_to_36bit_word(self, modern_float_fpm):
        """
        Strips a 64-bit modern optical pulse down to a 36-bit hex word 
        by mapping velocity deviations to deterministic 0.0V to 1.0V lines.
        """
        # Calculate raw deviation factor
        deviation = abs(modern_float_fpm - self.target_fpm)
        
        # Map analog voltage representation steps (0.0625V increments)
        if deviation <= 10.0:
            analog_voltage = 0.0625  # STATE_NORMAL_VELOCITY
        elif deviation <= 50.0:
            analog_voltage = 0.2500  # STATE_VELOCITY_FLUCTUATION_WARNING
        else:
            analog_voltage = 1.0000  # STATE_CRITICAL_AIR_FLOW_FAILURE
            
        # Convert the analog representation to a simulated 36-bit Octal/Hex mainframe word
        univac_word = f"0X{int(analog_voltage * 68719476735):09X}"
        return analog_voltage, univac_word

    def log_uvc_manifold_metrics(self, current_velocity_fpm):
        voltage, word = self.downconvert_to_36bit_word(current_velocity_fpm)
        print(f"[TELEMETRY] Current Air-Handling Velocity: {current_velocity_fpm} FPM")
        print(f"[TRANSLATOR] Analog Line Value: {voltage}V ==> 36-Bit Univac Word: {word}")
        
        if voltage == 1.0000:
            print("[ALERT] UN-SANITIZED AIR HAZARD: Negative pressure airflow boundary breached!")
        else:
            print("[STATUS] Air velocity matches bio-containment exposure time limits.")

if __name__ == "__main__":
    translator = UnivacAirDiagnostics()
    # Simulate a sudden restriction in the positive pressure ICU cyclone loop
    simulated_airflow = 320.0 
    translator.log_uvc_manifold_metrics(simulated_airflow)
