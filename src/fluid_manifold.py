// USS Iowa Medical Core: Fluidic Manifold Pump System
// Designed for safe automated blood/fluid distribution or CHT separation layers

$fn = 64;

// Global Manifold Structural Constants (in millimeters)
block_width   = 160.0;
block_depth   = 90.0;
block_height  = 70.0;
bore_radius   = 8.0;   // Main flow channel fluid clearance
valve_radius  = 14.0;  // Chamber for automated control solenoids

module solid_manifold_base() {
    difference() {
        // Main structural solid block
        color("darkgrey") cube([block_width, block_depth, block_height], center = true);
        
        // Horizontal Primary Fluid Bore (Longitudinal Transfer)
        rotate([0, 90, 0])
            cylinder(r = bore_radius, h = block_width + 5, center = true);
        
        // Transverse Core Channels (Cross-feed lines)
        for (x_offset = [-45, 0, 45]) {
            translate([x_offset, 0, 0])
                rotate([90, 0, 0])
                    cylinder(r = bore_radius, h = block_depth + 5, center = true);
        }
        
        // Vertical Solenoid Seating Cavities (Top-down valve insertion points)
        for (x_offset = [-45, 0, 45]) {
            translate([x_offset, 0, 10])
                cylinder(r = valve_radius, h = block_height/2 + 2, center = false);
        }
    }
}

module pressure_sensor_ports() {
    // Auxiliary feedback loops for pressure diagnostic pickups
    color("brass") {
        for (x_offset = [-22.5, 22.5]) {
            translate([x_offset, block_depth/2 - 5, 15])
                rotate([90, 0, 0])
                    difference() {
                        cylinder(r = 6, h = 15, center = true);
                        cylinder(r = 3, h = 18, center = true);
                    }
        }
    }
}

module mounting_flanges() {
    // Heavily reinforced brackets to lock assembly to the hull frame or equipment rack
    color("slategrey") {
        translate([-block_width/2 - 15, 0, -block_height/2 + 7.5])
            difference() {
                cube([30, block_depth - 20, 15], center = true);
                cylinder(r = 4.5, h = 20, center = true); // Secure bolt hole
            }
        translate([block_width/2 + 15, 0, -block_height/2 + 7.5])
            difference() {
                cube([30, block_depth - 20, 15], center = true);
                cylinder(r = 4.5, h = 20, center = true); // Secure bolt hole
            }
    }
}

// Combined Structural Composition
union() {
    solid_manifold_base();
    pressure_sensor_ports();
    mounting_flanges();
}
