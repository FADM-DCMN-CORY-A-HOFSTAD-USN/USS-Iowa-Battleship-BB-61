// USS Iowa Orthopedic Bed: Articulating Sub-Assembly
// Parametric Hydraulic Actuator and Pivot Hinge Matrix

$fn = 32;

base_plate_w = 930.0;
backrest_l   = 750.0;
cylinder_r   = 30.0;
stroke_ext   = 180.0; // Current extension parameter of the hydraulic ram

module mounting_pivot_brackets() {
    // Heavy dual-shear hinge brackets anchored to main bed rails
    color("dimgray") {
        translate([0,  base_plate_w/2 - 50, 0])
            difference() {
                cube([60, 40, 50], center=true);
                rotate([90, 0, 0]) cylinder(r=10, h=50, center=true);
            }
        translate([0, -base_plate_w/2 + 50, 0])
            difference() {
                cube([60, 40, 50], center=true);
                rotate([90, 0, 0]) cylinder(r=10, h=50, center=true);
            }
    }
}

module hydraulic_cylinder(extension) {
    // Dual-stage pneumatic/hydraulic cylinder for heavy patient manipulation
    rotate([0, -35, 0]) { // 35-degree entry inclination angle
        // Outer Pressure Sleeve
        color("darkblue") 
            cylinder(r=cylinder_r, h=250, center=false);
        // Internal Piston Rod 
        color("silver") 
            translate([0, 0, 200]) 
                cylinder(r=cylinder_r - 12, h=100 + extension, center=false);
    }
}

module articulating_frame_plate() {
    // Canvas/board support plane that forms the upper mattress support section
    rotate([0, -25, 0]) // Controlled tilt angle
    translate([backrest_l/2, 0, 15]) {
        color("charcoal", 0.9) 
            cube([backrest_l, base_plate_w - 40, 12], center=true);
        // Retaining edge lip to prevent mattress migration under roll conditions
        translate([backrest_l/2 - 6, 0, 20])
            color("black") cube([12, base_plate_w - 40, 40], center=true);
    }
}

// Render Composition Array
union() {
    mounting_pivot_brackets();
    articulating_frame_plate();
    
    // Left and Right High-Capacity Actuators
    translate([-120,  base_plate_w/3, -100]) hydraulic_cylinder(stroke_ext);
    translate([-120, -base_plate_w/3, -100]) hydraulic_cylinder(stroke_ext);
}
