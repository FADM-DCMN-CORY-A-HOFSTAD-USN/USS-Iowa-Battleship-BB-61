// File: docs/hardware/mechanical/biochem_centrifuge_rotor.scad
// System: USS Iowa Biochemical Lab Module - Centrifuge Separation Rotor
// Adheres to parameters for BIOCHEM-970-1070 and Verdura-Rx processing arrays

$fn = 72;

// Core Geometric Constraints (in millimeters)
rotor_radius        = 95.0;
rotor_thickness     = 28.0;
center_shaft_radius = 8.0;
bucket_count        = 6;
bucket_radius       = 14.0;
bucket_depth        = 45.0;

module separation_rotor_hub() {
    difference() {
        // Main structural flywheel hub
        color("darkslategray") cylinder(r = rotor_radius, h = rotor_thickness, center = true);
        
        // Central drive shaft coupling
        cylinder(r = center_shaft_radius, h = rotor_thickness + 5, center = true);
        
        // Weight-reduction cutouts for faster spin velocity response
        for (i = [0 : bucket_count - 1]) {
            rotate([0, 0, i * (360 / bucket_count)]) {
                // Symmetric fluid bucket cavities
                translate([rotor_radius * 0.68, 0, rotor_thickness/2 - bucket_depth/2 + 2])
                    cylinder(r = bucket_radius, h = bucket_depth + 2, center = true);
                
                // Structural relief pockets near the core
                translate([rotor_radius * 0.35, 0, 0])
                    cube([20, 15, rotor_thickness + 2], center = true);
            }
        }
    }
}

module balancing_pins() {
    // Heavy brass stabilization weights positioned to cancel out structural harmonics
    color("gold") {
        for (i = [0 : bucket_count - 1]) {
            rotate([0, 0, (i * (360 / bucket_count)) + (360 / (bucket_count * 2))])
                translate([rotor_radius * 0.85, 0, 0])
                    cylinder(r = 3.5, h = rotor_thickness - 6, center = true);
        }
    }
}

// Composite System Assembly Execution
union() {
    separation_rotor_hub();
    balancing_pins();
}
