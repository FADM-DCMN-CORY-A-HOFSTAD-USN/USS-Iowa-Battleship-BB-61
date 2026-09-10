// =========================================================================
// SPECIFICATION FILE: mechanical_blueprints.scad
// DESCRIPTION: Propeller Shaft MHD Sleeves & Keel Hydraulic Actuator Pockets
// =========================================================================

$fn = 120; // High-fidelity geometric rendering resolution

// --- Core Propulsion Parameters ---
shaft_diameter       = 610.0;   // Historical Iowa-class shaft core thickness (mm)
gallium_sleeve_gap   = 15.0;    // Fluid dynamic clearance for liquid metal layer (mm)
mhd_housing_outer_r  = 450.0;   // Outer electromagnetic coil radius (mm)

// --- Core Actuator Parameters ---
piston_rod_diameter  = 450.0;   // Solid Titanium (Ti-6Al-4V) core (mm)
cylinder_bore_r      = 350.0;   // 700mm structural bore radius (mm)
pocket_depth         = 2200.0;  // Keel embedding depth allowance (mm)

module MHD_Propeller_Shaft_Sleeve(d_shaft=shaft_diameter, gap=gallium_sleeve_gap, r_ext=mhd_housing_outer_r) {
    difference() {
        // Outer Electromagnetic Coil Structural Housing
        cylinder(h=1200, r=r_ext, center=true);
        // Liquid Gallium Conductive Layer Cavity Void
        cylinder(h=1202, r=(d_shaft/2) + gap, center=true);
        // Interior Shaft Passage Tolerance Path
        cylinder(h=1204, r=d_shaft/2, center=true);
    }
}

module Keel_Hydraulic_Actuator_Pocket(r_bore=cylinder_bore_r, d_rod=piston_rod_diameter, depth=pocket_depth) {
    difference() {
        // Heavy Cast Steel Keel Mounting Block Block
        cube([1100, 1100, depth], center=true);
        // Internal Forged Steel Cylinder Casing Cavity
        translate([0, 0, 100])
            cylinder(h=depth - 200, r=r_bore, center=true);
        // Lower Clearance Passage for the Titanium Actuator Rod
        translate([0, 0, -500])
            cylinder(h=depth, r=(d_rod/2) + 15, center=true);
    }
}

// Renders compilation assembly for architectural validation
translate([-1200, 0, 0]) MHD_Propeller_Shaft_Sleeve();
translate([1200, 0, 0])  Keel_Hydraulic_Actuator_Pocket();
