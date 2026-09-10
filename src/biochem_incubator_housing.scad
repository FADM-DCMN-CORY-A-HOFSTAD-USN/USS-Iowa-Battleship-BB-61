// File: docs/hardware/mechanical/biochem_incubator_housing.scad
// System: USS Iowa Biochemical Lab Module - Shock-Stabilized Incubator Housing
// Adheres to parameters for BIOCHEM-970-1070 and Verdura-Rx processing arrays

$fn = 64;

// Housing Enclosure Parameters (in millimeters)
ext_width   = 280.0;
ext_depth   = 220.0;
ext_height  = 200.0;
insulation_t = 12.0;
wall_t       = 4.0;

module insulated_outer_shell() {
    difference() {
        // Outer Protective Armor Hull
        color("slategrey") 
            cube([ext_width, ext_depth, ext_height], center = true);
        
        // Inner Insulation Cavity Boundary
        cube([ext_width - (wall_t * 2), 
              ext_depth - (wall_t * 2), 
              ext_height - (wall_t * 2)], center = true);
    }
}

module internal_incubation_chamber() {
    // Suspended internal structural compartment hosting internal processing trays
    inner_w = ext_width - (wall_t * 2) - (insulation_t * 2);
    inner_d = ext_depth - (wall_t * 2) - (insulation_t * 2);
    inner_h = ext_height - (wall_t * 2) - (insulation_t * 2);

    translate([0, 0, 0]) {
        difference() {
            // Lab Grade Chamber Core Block
            color("ghostwhite", 0.8) 
                cube([inner_w, inner_d, inner_h], center = true);
            
            // Working Core Volume Cutout
            cube([inner_w - 6, inner_d - 6, inner_h - 6], center = true);
        }
        
        // Internal Rack Guide Support Tracks
        color("silver") {
            for (z_offset = [-30, 0, 30]) {
                translate([0, 0, z_offset])
                    cube([inner_w - 4, inner_d - 2, 3], center = true);
            }
        }
    }
}

module heavy_deck_shock_absorbers() {
    // Corner industrial spring/elastomer isolation mount points to handle hull shock
    mount_r = 18.0;
    mount_h = 35.0;
    
    positions = [
        [ ext_width/2 - 20,  ext_depth/2 - 20],
        [ ext_width/2 - 20, -ext_depth/2 + 20],
        [-ext_width/2 + 20,  ext_depth/2 - 20],
        [-ext_width/2 + 20, -ext_depth/2 + 20]
    ];
    
    for (pos = positions) {
        translate([pos, pos, -ext_height/2 - mount_h/2]) {
            // Outer Rubber Buffer boot
            color("black") cylinder(r = mount_r, h = mount_h, center = true);
            // Steel anchor rod core
            color("darkgrey") cylinder(r = 5.0, h = mount_h + 10, center = true);
        }
    }
}

// Global System Evaluation Model Construction
union() {
    insulated_outer_shell();
    internal_incubation_chamber();
    heavy_deck_shock_absorbers();
}
