// File: docs/hardware/mechanical/biochem_motorized_valve_block.scad
// System: USS Iowa Biochemical Lab Module - Motorized Fluidic Valve Blocks
// Machined alloy selector block with internal high-precision fluidic channels

$fn = 64;

// Selector Valve Dimensions (in millimeters)
valve_diameter = 90.0;
valve_height   = 65.0;
port_radius    = 3.5;
inlet_count    = 6;

module main_valve_body() {
    difference() {
        // Core structural cylinder block
        color("silver") cylinder(r = valve_diameter/2, h = valve_height, center = true);
        
        // Central Rotor Cavity (For the automated inner selection plug)
        cylinder(r = valve_diameter/4, h = valve_height + 2, center = true);
        
        // Common Outlet Bore (Exits out the absolute bottom base plate)
        translate([0, 0, -valve_height/2 - 1])
            cylinder(r = port_radius, h = valve_height/2 + 2, center = false);
        
        // Radial Inlet Channels (Radial port distribution)
        for (i = [0 : inlet_count - 1]) {
            rotate([0, 0, i * (360 / inlet_count)]) {
                translate([0, 0, 10])
                    rotate([0, 90, 0])
                        cylinder(r = port_radius, h = valve_diameter/2 + 2, center = false);
            }
        }
    }
}

module internal_selector_plug() {
    // Concentric rotating distribution plug driven via NEMA stepper motor
    translate([0, 0, 0]) {
        color("darkblue", 0.7) {
            difference() {
                cylinder(r = valve_diameter/4 - 0.2, h = valve_height - 2, center = true);
                
                // Internal L-Bore Channel (Directs exactly ONE active path to bottom common outlet)
                translate([0, 0, 10])
                    rotate([0, 90, 0])
                        cylinder(r = port_radius, h = valve_diameter/4, center = false);
                
                translate([0, 0, -valve_height/2])
                    cylinder(r = port_radius, h = valve_height/2 + 11, center = false);
                    
                // Top-side D-Shaft interface coupling for the stepper motor head
                translate([0, 0, valve_height/2 - 12])
                    cylinder(r = 5.0, h = 15, center = true);
            }
        }
    }
}

module compression_fitting_mounts() {
    // Threaded outer bosses for locking surgical lines into the matrix
    color("brass") {
        for (i = [0 : inlet_count - 1]) {
            rotate([0, 0, i * (360 / inlet_count)]) {
                translate([valve_diameter/2 + 4, 0, 10])
                    rotate([0, 90, 0])
                        difference() {
                            cylinder(r = port_radius + 4, h = 10, center = true);
                            cylinder(r = port_radius + 1, h = 12, center = true);
                        }
            }
        }
    }
}

// System Hardware Compositing Tree
union() {
    main_valve_body();
    internal_selector_plug();
    compression_fitting_mounts();
}
