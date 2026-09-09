// Parametric Naval Orthopedic Fracture Bed Framework
// Designed for USS Iowa (BB-61) and Hospital Ship Ward Integration

$fn = 48;

// Structural Dimensions (in millimeters)
bed_length      = 2100.0;
bed_width       = 950.0;
frame_height    = 600.0;
traction_height = 2000.0;
rail_thickness  = 35.0;

module main_bed_chassis() {
    // Heavy steel frame rails designed for deck welding or high-load tie-downs
    difference() {
        // Outer perimeter box
        cube([bed_length, bed_width, rail_thickness], center = true);
        // Core cutout for spring/mesh canvas integration
        cube([bed_length - 80, bed_width - 80, rail_thickness + 2], center = true);
    }
    
    // Segmented Backrest (Articulating Component)
    translate([bed_length/4, 0, rail_thickness/4])
        rotate([0, -15, 0]) // 15-degree incline for high-fracture stabilization
        color("darkslategray") cube([bed_length/2 - 20, bed_width - 90, rail_thickness/2], center = true);
}

module overhead_traction_rigging() {
    // Overhead Balfour/Bohler-style fracture suspension framework
    color("silver") {
        // Vertical corner support stanchions
        translate([ bed_length/2 - 40,  bed_width/2 - 40, traction_height/2 - frame_height]) cylinder(r=15, h=traction_height);
        translate([ bed_length/2 - 40, -bed_width/2 + 40, traction_height/2 - frame_height]) cylinder(r=15, h=traction_height);
        translate([-bed_length/2 + 40,  bed_width/2 - 40, traction_height/2 - frame_height]) cylinder(r=15, h=traction_height);
        translate([-bed_length/2 + 40, -bed_width/2 + 40, traction_height/2 - frame_height]) cylinder(r=15, h=traction_height);
        
        // Longitudinal overhead slider bars
        translate([0,  bed_width/2 - 40, traction_height - frame_height]) rotate([0, 90, 0]) cylinder(r=12, h=bed_length, center=true);
        translate([0, -bed_width/2 + 40, traction_height - frame_height]) rotate([0, 90, 0]) cylinder(r=12, h=bed_length, center=true);
        
        // Transverse pulley mounting bars
        for (offset = [-bed_length/3, 0, bed_length/3]) {
            translate([offset, 0, traction_height - frame_height]) rotate([90, 0, 0]) cylinder(r=12, h=bed_width - 80, center=true);
        }
    }
}

module support_legs_and_deck_mounts() {
    // Shock-absorbing support assembly to mitigate blast forces through the ship deck
    leg_positions = [
        [ bed_length/2 - 100,  bed_width/2 - 100],
        [ bed_length/2 - 100, -bed_width/2 + 100],
        [-bed_length/2 + 100,  bed_width/2 - 100],
        [-bed_length/2 + 100, -bed_width/2 + 100]
    ];
    
    for(pos = leg_positions) {
        translate([pos[0], pos[1], -frame_height/2]) {
            // Main Leg Stanchion
            color("slategrey") cylinder(r=25, h=frame_height, center=true);
            // Deck Flange Mounting Block
            translate([0, 0, -frame_height/2 + 10])
                color("dimgray") cube([90, 90, 20], center=true);
        }
    }
}

// Global Scene Matrix Integration
union() {
    translate([0, 0, 0]) main_bed_chassis();
    overhead_traction_rigging();
    support_legs_and_deck_mounts();
}
