// =========================================================================
// SPECIFICATION FILE: mechanical_blueprints.scad
// DESCRIPTION: Propeller Shaft MHD Sleeves, Actuator Pockets, & Heavy Turret Springs
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

// --- Heavy Turret Recoil Spring Parameters ---
// Inspired by high-performance multi-strand firearm recoil spring kits (Sig Sauer style)
spring_wire_diameter = 85.0;    // Structural spring steel thickness (mm)
spring_outer_radius  = 400.0;   // Total footprint radius of the damper coil (mm)
spring_coils         = 14;      // Active compression turns
spring_free_height   = 1800.0;  // Uncompressed baseline height (mm)

module MHD_Propeller_Shaft_Sleeve(d_shaft=shaft_diameter, gap=gallium_sleeve_gap, r_ext=mhd_housing_outer_r) {
    difference() {
        cylinder(h=1200, r=r_ext, center=true);
        cylinder(h=1202, r=(d_shaft/2) + gap, center=true);
        cylinder(h=1204, r=d_shaft/2, center=true);
    }
}

module Keel_Hydraulic_Actuator_Pocket(r_bore=cylinder_bore_r, d_rod=piston_rod_diameter, depth=pocket_depth) {
    difference() {
        cube([1100, 1100, depth], center=true);
        cylinder(h=depth - 200, r=r_bore, center=true);
        translate([0, 0, -500])
            cylinder(h=depth, r=(d_rod/2) + 15, center=true);
    }
}

module Surgical_Citadel_Recoil_Spring(w_d=spring_wire_diameter, o_r=spring_outer_radius, c=spring_coils, h=spring_free_height) {
    union() {
        for (i = [0 : c-1]) {
            translate([0, 0, (h / c) * i])
                rotate([0, 0, (360 / c) * i * 3])
                    translate([o_r - w_d, 0, 0])
                        sphere(r=w_d);
        }
    }
}

// Renders compilation assembly for architectural validation
translate([-1500, 0, 0]) MHD_Propeller_Shaft_Sleeve();
translate([0, 0, 0])      Keel_Hydraulic_Actuator_Pocket();
translate([1500, 0, 0])   Surgical_Citadel_Recoil_Spring();
