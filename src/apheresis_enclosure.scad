// USS Iowa BB-61: Apheresis Enclosure & Shock Mounting Framework
// Adhering to BIOCHEM-970-1070 and Univac-IX structural layouts

$fn = 64;

// Global System Dimensions (in millimeters)
enclosure_width  = 320.0;
enclosure_depth  = 240.0;
enclosure_height = 180.0;
wall_thickness   = 5.0;

module main_enclosure() {
    difference() {
        // External Solid Hull
        cube([enclosure_width, enclosure_depth, enclosure_height], center = true);
        
        // Internal Cavity
        cube([enclosure_width - (wall_thickness * 2), 
              enclosure_depth - (wall_thickness * 2), 
              enclosure_height - (wall_thickness * 2)], center = true);
        
        // Front Service Access Panel cutout
        translate([0, enclosure_depth/2 - wall_thickness/2, 0])
            cube([enclosure_width - 40, wall_thickness + 2, enclosure_height - 40], center = true);
    }
}

module centrifuge_chamber() {
    // Specialized housing for Verdura-Rx Whole Blood Processing Component
    chamber_radius = 65.0;
    chamber_height = 110.0;
    
    translate([-40, -20, -(enclosure_height/2) + chamber_height/2 + wall_thickness]) {
        difference() {
            cylinder(r = chamber_radius + 4, h = chamber_height, center = true);
            cylinder(r = chamber_radius, h = chamber_height + 2, center = true);
        }
        // Central spindle axis for rotation system
        color("darkgray") cylinder(r = 6.0, h = chamber_height + 10, center = true);
    }
}

module kicad_board_mounts() {
    // Mounting standoffs for the Univac-IX Hexadecimal controller board
    standoff_height = 12.0;
    standoff_radius = 4.0;
    hole_radius     = 1.6; // For M3 hardware integration
    
    // Pattern layout matches PCB dimensions (100mm x 80mm)
    positions = [, [50, -40], [-50, 40], [-50, -40]
    ];
    
    translate([60, 30, -(enclosure_height/2) + wall_thickness]) {
        for (p = positions) {
            translate([p[0], p[1], standoff_height/2]) {
                difference() {
                    cylinder(r = standoff_radius, h = standoff_height, center = true);
                    cylinder(r = hole_radius, h = standoff_height + 2, center = true);
                }
            }
        }
    }
}

// System Assembly Composition
union() {
    color("slategrey", 0.8) main_enclosure();
    color("crimson", 0.5)    centrifuge_chamber();
    color("forestgreen")     kicad_board_mounts();
}
