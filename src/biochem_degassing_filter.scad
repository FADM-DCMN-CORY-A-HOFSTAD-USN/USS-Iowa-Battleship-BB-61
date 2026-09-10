// File: docs/hardware/mechanical/biochem_degassing_filter.scad
// System: USS Iowa Biochemical Lab Module - Fluid Degassing Filtration Blocks
// Multi-layer chamber utilizing localized vacuum extraction arrays

$fn = 64;

// Chamber Hull Geometry (in millimeters)
housing_radius = 48.0;
housing_height = 110.0;
wall_thickness = 4.5;
membrane_layers = 5;
pore_bore_r    = 3.0;

module outer_filter_capsule() {
    difference() {
        // Main structural holding column
        color("teal", 0.6) 
            cylinder(r = housing_radius, h = housing_height, center = true);
        
        // Internal Extraction Core Volume
        cylinder(r = housing_radius - wall_thickness, h = housing_height - 12, center = true);
        
        // Lateral Vacuum Port Port Interface (Side extraction line)
        translate([housing_radius - 2, 0, housing_height * 0.25])
            rotate([0, 90, 0])
                cylinder(r = 5.0, h = wall_thickness + 10, center = true);
    }
}

module membrane_filter_matrix() {
    // Layered hydrophobic disc plates that capture micro-bubbles under negative pressure
    color("ghostwhite", 0.9) {
        step_z = (housing_height - 30) / (membrane_layers + 1);
        for (i = [1 : membrane_layers]) {
            translate([0, 0, (-housing_height/2 + 15) + (i * step_z)]) {
                difference() {
                    // Solid separation membrane disc
                    cylinder(r = housing_radius - wall_thickness - 0.2, h = 3.5, center = true);
                    
                    // Micro-perforation fluid pass-through patterns
                    for (r_offset = [10 : 10 : housing_radius - 12]) {
                        for (angle = [0 : 45 : 350]) {
                            rotate([0, 0, angle + (i * 15)]) // Staggered perforation angles
                                translate([r_offset, 0, 0])
                                    cylinder(r = 1.2, h = 6, center = true);
                        }
                    }
                }
            }
        }
    }
}

module fluid_port_adapters() {
    // High-load compression couplings for inlet and outlet lines
    color("darkblue") {
        // Top Primary Fluid Inlet
        translate([0, 0, housing_height/2 + 4])
            difference() {
                cylinder(r = pore_bore_r + 5, h = 10, center = true);
                cylinder(r = pore_bore_r, h = 12, center = true);
            }
        // Bottom Degassed Fluid Outlet
        translate([0, 0, -housing_height/2 - 4])
            difference() {
                cylinder(r = pore_bore_r + 5, h = 10, center = true);
                cylinder(r = pore_bore_r, h = 12, center = true);
            }
    }
}

// Complete Filter Compilation Pipeline
union() {
    outer_filter_capsule();
    membrane_filter_matrix();
    fluid_port_adapters();
}
