// File: docs/hardware/mechanical/biochem_reagent_mixer.scad
// System: USS Iowa Biochemical Lab Module - Heated Fluid Preparation Manifold
// Configured to support real-time whole blood asset modification lines

$fn = 64;

// Block Dimensions (in millimeters)
block_x = 140.0;
block_y = 80.0;
block_z = 45.0;

fluid_bore_r = 4.5;
heater_element_r = 8.0;

module heated_mixer_chassis() {
    difference() {
        // Main thermal block substrate
        color("silver") cube([block_x, block_y, block_z], center = true);
        
        // Primary Fluid Mixing Line (Internal Bore Pattern)
        rotate([0, 90, 0])
            cylinder(r = fluid_bore_r, h = block_x + 10, center = true);
        
        // Helical Mixing Baffle Cavities (Transverse cutouts to enforce turbulent flow mixing)
        for (offset = [-40, -20, 0, 20, 40]) {
            translate([offset, 0, 0])
                rotate([90, 0, 0])
                    cylinder(r = fluid_bore_r * 1.8, h = block_y - 20, center = true);
        }
        
        // Cartridge Heater Elements Wells (Dual parallel placements for balanced heat spread)
        translate([0,  block_y/2 - 15, -block_z/2 + 20])
            rotate([0, 90, 0])
                cylinder(r = heater_element_r, h = block_x - 20, center = true);
                
        translate([0, -block_y/2 + 15, -block_z/2 + 20])
            rotate([0, 90, 0])
                cylinder(r = heater_element_r, h = block_x - 20, center = true);
        
        // Thermistor Diagnostic Well
        translate([0, 0, block_z/2 - 12])
            cylinder(r = 3.0, h = 25, center = true);
    }
}

module inlet_outlet_flanges() {
    // Heavy fluid coupling adapters matching standard clinical standard lines
    color("darkblue") {
        translate([-block_x/2 - 5, 0, 0])
            rotate([0, 90, 0]) cylinder(r = fluid_bore_r + 4, h = 10, center = true);
        translate([block_x/2 + 5, 0, 0])
            rotate([0, 90, 0]) cylinder(r = fluid_bore_r + 4, h = 10, center = true);
    }
}

// System Rendering Pipeline Execution
union() {
    heated_mixer_chassis();
    inlet_outlet_flanges();
}
