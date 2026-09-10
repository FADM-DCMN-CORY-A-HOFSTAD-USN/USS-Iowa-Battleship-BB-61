// =========================================================================
// ENTERPRISE ARCHITECTURE INTEGRATION STANDARD - SPECIFICATION FILE: lifting_pockets.scad
// DESCRIPTION: Parametric Structural Anchoring Pockets for Hull Lift Actuators
// LICENSE: Boost Software License (BSL-1.0)
// =========================================================================

$fn = 120; // High-fidelity geometric rendering resolution

// --- Core Mechanical Dimensions (mm) ---
cylinder_bore_outer_r  = (700 / 2) + 50;  // 700mm bore radius + 50mm steel wall thickness
clevis_flange_width    = 900.0;           // Total footprint width of the anchoring flange
pocket_depth           = 2200.0;          // Total structural recess depth into keel plates (2.2m)
stroke_clearance       = 1800.0;          // Dynamic operational range parameter
wall_thickness         = 75.0;            // Heavy reinforcement casing thickness

module Lift_Actuator_Pocket(r=cylinder_bore_outer_r, f_w=clevis_flange_width, d=pocket_depth, t=wall_thickness) {
    difference() {
        // 1. Primary Mass Block: Cast Steel Structural Keel Node
        translate([-f_w/2, -f_w/2, 0])
            cube([f_w, f_w, d], center=false);
        
        // 2. Central Cylinder Recess Casing Void
        translate([0, 0, -1])
            cylinder(h=d - 200, r=r, center=false);
            
        // 3. Lower Extension Passage (Passage for the 450mm Titanium Rod)
        translate([0, 0, -1])
            cylinder(h=d + 2, r=(450 / 2) + 20, center=false);
            
        // 4. Anchor Bolt Ring (12x Sub-Structural Threaded Mounting Holes)
        for (i = [0 : 11]) {
            rotate([0, 0, i * 30])
                translate([r + 60, 0, d - 150])
                    cylinder(h=152, r=24, center=false); // 48mm heavy fasteners
        }
    }
}

// --- Keel Array Longitudinal Layout ---
// Spaces out 6 heavy lift pockets linearly along the primary longitudinal center line
for (z_axis = [0 : 5]) {
    translate([0, z_axis * 4500, 0]) // 4.5-meter center-to-center spacing
        Lift_Actuator_Pocket();
}
