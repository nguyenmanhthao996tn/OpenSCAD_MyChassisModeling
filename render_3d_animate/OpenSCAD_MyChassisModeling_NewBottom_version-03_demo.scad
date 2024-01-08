$fn=128;

// =====================================

// Bottom Chassis
draw_bottom_chassis();

// Rotational Fixing Part
translate([0, 0, -animation_moving_distance($t)])
draw_rotational_fixing_part();

// Fixing VIS
translate([0, 0, 1.5*animation_moving_distance($t)])
draw_fixing_vias();

// Extender
translate([0, 0, -2*animation_moving_distance($t)])
draw_extender();

// Solar PCBs
translate([animation_moving_distance($t), 0, 0])
draw_solar_pcbs(0);

translate([0, animation_moving_distance($t), 0])
draw_solar_pcbs(1);

translate([-animation_moving_distance($t), 0, 0])
draw_solar_pcbs(2);

translate([0, -animation_moving_distance($t), 0])
draw_solar_pcbs(3);

// =====================================

function animation_moving_distance(t) = t < 0.3 ? 0 : (t-0.3)*100;

module draw_bottom_chassis() {
    color("grey") render()
    translate([0, 0, -9.5])
    rotate([180, 0, 0])
    import("./../render_3d_models/OpenSCAD_MyChassisModeling_NewBottom_version-03_w_slot.stl");
}

module draw_rotational_fixing_part() {
    color("blue") render()
    translate([0, 0, -9.5+2])
    rotate([180, 0, 0])
    import("./../render_3d_models/OpenSCAD_MyChassisModeling_NewBottom_version-03_fixing_part.stl");
}

module draw_fixing_vias() {
    color("orange") render()
    import("./../vis_types/vis_flathead_m10_l45.stl");
}

module draw_extender() {
    color("brown") render()
    translate([0, 0, -9.5])
    rotate([180, 0, 0])
    cylinder(h=500, d=20, center=false);
}

module draw_solar_pcbs(index) {
    color("green") render() {
        rotate([0, 0, index*90])
        draw_a_solar();
    }
}

module draw_a_solar() {
    translate([40, 0, -9.5])
    rotate([180, 0, 0])
    difference() {
        translate([0, -50, 0])
        cube([340, 100, 2], center=false);

        translate([5, 45, 0])
        cube([10, 10, 500], center=true);

        translate([5, -45, 0])
        cube([10, 10, 500], center=true);
    }
}