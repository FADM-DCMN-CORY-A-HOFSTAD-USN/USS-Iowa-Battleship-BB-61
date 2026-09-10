// File: docs/hardware/mechanical/biochem_extraction_syringe.scad
// System: USS Iowa Biochemical Lab Module - Motorized Fluid Extraction Syringe
// High-accuracy linear stepper-driven positive displacement pump geometry

$fn = 64;

// Syringe and Linear Rail Parameters (in millimeters)
barrel_length  = 160.0;
barrel_outer_r = 18.0;
barrel_wall_t  = 2.5;
plunger_pos    = 75.0; // Dynamic parameter: linear displacement down the track
rod_radius     = 4.0;

module pump_barrel() {
    difference() {
        // Transparent Main Fluid Reservoir Cylinder
        color("ghostwhite", 0.4) 
            cylinder(r = barrel_outer_r, h = barrel_length, center = true);
        
        // Internal Fluid Storage Core
        cylinder(r = barrel_outer_r - barrel_wall_t, h = barrel_length + 2, center = true);
        
        // Mounting cutout slot for optical level fluid tracking sensors
        translate([0, barrel_outer_r - 2, 0])
            cube([6, 6, barrel_length - 40], center = true);
    }
    
    // Front Discharge Nozzle Adapter (Luer-Lock integration zone)
    translate([0, 0, barrel_length/2 + 8]) {
        color("darkblue") {
            difference() {
                cylinder(r = 5.0, h = 16, center = true);
                cylinder(r = 2.0, h = 18, center = true); // Internal fluid egress path
            }
        }
    }
}

module motorized_plunger_assembly(displacement) {
    // Internal sealing piston ring and mechanical lead screw drive coupling
    translate([0, 0, -barrel_length/2 + displacement]) {
        // Neoprene primary sealing face gasket
        color("black") 
            cylinder(r = barrel_outer_r - barrel_wall_t - 0.1, h = 12, center = true);
        
        // Stainless steel driving pushrod extending backwards to linear guide block
        translate([0, 0, -barrel_length/4 - 6])
            color("silver") 
                cylinder(r = rod_radius, h = barrel_length/2, center = true);
    }
}

module linear_actuator_rails() {
    // Structural framework brackets anchoring lead screw bearings and guide rods
    color("darkgrey") {
        // Backstop stepper motor structural adapter plate
        translate([0, 0, -barrel_length/2 - 35])
            cube([55, 55, 10], center = true);
            
        // Dual lateral guide support rods preventing rotational torque displacement
        translate([ 25, 0, -20]) cylinder(r = 3.0, h = barrel_length + 40, center = true);
        translate([-25, 0, -20]) cylinder(r = 3.0, h = barrel_length + 40, center = true);
    }
}

// Complete Assembly Pipeline Compilation
union() {
    pump_barrel();
    motorized_plunger_assembly(plunger_pos);
    linear_actuator_rails();
}
