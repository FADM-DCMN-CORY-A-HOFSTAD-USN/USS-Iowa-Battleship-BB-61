// Parametric Naval Iron Lung Chassis - Haven-Class (AH-12) Suite\
// Designed for structural layout confirmation inside shipboard wards

$fn = 50;

tank_length = 2000;\
tank_radius = 400;\
wall_thickness = 6;\
viewing_port_count = 3;

module iron_lung_body() {\
    rotate([0, 90, 0]) {\
        difference() {\
            // Main Cylindrical Pressure Vessel\
            cylinder(r = tank_radius, h = tank_length, center = true);\
            cylinder(r = tank_radius - wall_thickness, h = tank_length + 2, center = true);

            // Cutouts for Side Viewing/Access Ports\
            for(i = [1 : viewing_port_count]) {\
                translate([200, 0, -tank_length/2 + (i * (tank_length / (viewing_port_count + 1)))])\
                    cube([100, 150, 100], center = true);\
            }\
        }\
    }\
}

module bellows_pump_assembly() {\
    // Mechanical bellows mechanism for pressure cycling\
    translate([-tank_length/2 - 100, 0, -tank_radius + 100]) {\
        color("darkslategray") cube([200, 300, 300], center = true);\
        color("silver") translate([-100, 0, 0]) rotate([0, 90, 0]) cylinder(r=20, h=150);\
    }\
}

module shipboard_shock_mounts() {\
    // Ruggedized floor mounts to handle ship roll and blast vibrations\
    spacing = tank_length * 0.35;\
    for(z = [-spacing, spacing]) {\
        translate([z, 0, -tank_radius - 50]) {\
            difference() {\
                cube([100, tank_radius * 1.5, 100], center = true);\
                rotate([0, 90, 0]) cylinder(r = 12, h = 120, center = true); // Shock pin cutout\
            }\
        }\
    }\
}

// Final Assembly Execution\
union() {\
    color("cadetblue", 0.7) iron_lung_body();\
    bellows_pump_assembly();\
    color("dimgray") shipboard_shock_mounts();\
}
