// =========================================================================
// ENTERPRISE ARCHITECTURE INTEGRATION STANDARD - SPECIFICATION FILE: medical_blueprints.scad
// LICENSE: Boost Software License (BSL-1.0)
// =========================================================================

$fn = 100;

// --- Actuator Pocket Anchor Geometry ---
module Hydraulic_Lifting_Pocket(bore=700, stroke=1800) {
    difference() {
        cube([1000, 1000, stroke + 400], center=true);
        // Main cylinder core clearance
        cylinder(h=stroke + 410, r=bore/2, center=true);
        // Lower passageway for 450mm titanium rod
        translate([0,0,-200])
            cylinder(h=stroke, r=450/2, center=true);
    }
}

// --- Medical Peltier Storage Box & Cooling Shelf Trays ---
module Medical_Cooling_Shelf(width=600, depth=800, height=400) {
    difference() {
        // Outer Insulated Composite Structure
        cube([width, depth, height], center=true);
        // Internal Storage Volume Vault
        translate([0, 0, 10])
            cube([width - 40, depth - 40, height - 40], center=true);
        // Left Wall Cutout: Solid-State Peltier Module Interface Port
        translate([-(width/2), 0, 0])
            cube([50, 120, 120], center=true);
    }
    // Slide-Out Aluminum Storage Tray Inserts
    translate([0, 0, -50])
        cube([width - 50, depth - 60, 15], center=true);
}

// Instantiate side-by-side array for engineering review
translate([-1000, 0, 0]) Hydraulic_Lifting_Pocket();
translate([1000, 0, 0])  Medical_Cooling_Shelf();
