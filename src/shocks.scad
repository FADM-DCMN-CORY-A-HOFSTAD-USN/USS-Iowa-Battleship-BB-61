// =========================================================================
// ENTERPRISE ARCHITECTURE INTEGRATION STANDARD - SPECIFICATION FILE: shocks.scad
// DESCRIPTION: Parametric Vulcanized Rubber Shock Absorber for Peltier Arrays
// LICENSE: Boost Software License (BSL-1.0)
// =========================================================================

$fn = 100; // Force high-fidelity geometric rendering resolution

// --- Core Material Attributes ---
peltier_width     = 40.0;  // Footprint of standard ceramic element (mm)
stud_diameter     = 8.0;   // Diameter of the core titanium retention bolt (mm)
dampener_height   = 25.0;  // Total height of the vulcanized rubber cylinder (mm)
shoulder_radius   = 16.0;  // Radius of the widest mechanical absorption flange (mm)
inner_clearance   = 0.5;   // Expansion tolerance clearance parameter (mm)

module Peltier_Shock_Absorber(w=peltier_width, d=stud_diameter, h=dampener_height, r=shoulder_radius) {
    difference() {
        // 1. Primary Structural Body: Double-Conic Damping Shoulder
        union() {
            // Lower Flange Section
            cylinder(h=h*0.4, r1=r*1.2, r2=r, center=false);
            // Mid-Section Shear Isolation Ring
            translate([0, 0, h*0.4])
                cylinder(h=h*0.2, r=r, center=false);
            // Upper Flange Section (Mirror-Cap Convergence)
            translate([0, 0, h*0.6])
                cylinder(h=h*0.4, r1=r, r2=r*1.2, center=false);
        }
        
        // 2. Central Core Punch-Out: Rigid Titanium Stud Passage
        translate([0, 0, -1])
            cylinder(h=h+2, r=(d/2) + inner_clearance, center=false);
            
        // 3. Counter-Bore Recess: Sealed Boot O-Ring Seat (Upper Interface)
        translate([0, 0, h - 4.0])
            cylinder(h=5, r=r*0.75, center=false);
            
        // 4. Counter-Bore Recess: Sealed Boot O-Ring Seat (Lower Interface)
        translate([0, 0, -1])
            cylinder(h=5, r=r*0.75, center=false);
    }
}

// --- Layout Assembly Render Matrix ---
// Instantiates a 4x4 array of shock-absorber blocks protecting the Peltier base
spacing = peltier_width + 12.0;
for (x = [0 : 3]) {
    for (y = [0 : 3]) {
        translate([x * spacing, y * spacing, 0])
            Peltier_Shock_Absorber();
    }
}
