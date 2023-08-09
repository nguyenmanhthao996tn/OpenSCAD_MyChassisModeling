$fn=100;

/*** GLOBAL VARIABLES ***/
// The pillar
pillar_size = 8.5;
pillar_z = 20;
pillar_z_offset = 8.5;

// The pillar HOLES
pillar_hole_offset = -5.5;
pillar_hole_diameter = 3.05;

// The connector
connector_thickness = 2.5;

// The connector HOLES
connector_hole_distance = 60;
connector_hole_diameter = 3.05;

/*** MAIN ***/
//color("#0000AF")
//render()
draw_chassis();

/*** FUNCTION DEFINE ***/

module draw_chassis() {
    union() {
        draw_connectors();
        draw_pillars();
    }
}

module draw_a_pillar() {
    translate([0, 0, pillar_z_offset])
    difference() {
        // Pillar (shifted)
        translate([0, 0, -(pillar_z/2)])
        cube([pillar_size, pillar_size, pillar_z], center = true);
        
        // Pillar top cutout
        for (z=[90:90:270])
        rotate_copy([0, 0, z])
        translate([0, pillar_size+1.85, 0])
        rotate([45, 0, 0])
        cube([pillar_size+1, pillar_size+1, 100], center=true);
    }
}

module draw_a_pillar_w_holes() {
    difference() {
        // Pillar (shifted)
        draw_a_pillar();
        
        // Hole
        draw_pillar_holes();
    }
}

module draw_pillar_holes() {
    rotate_copy([0, 0, 90])
    translate([0, 0, pillar_hole_offset])
    rotate([0, 90, 0])
    cylinder(h=100, r=(pillar_hole_diameter/2), center=true);
}

module draw_pillars() {
    for (z=[0:90:270]) rotate_copy([0, 0, z])
    translate([-50+(pillar_size/2), -50+(pillar_size/2), 0])
    draw_a_pillar_w_holes();
}

module draw_a_connector() {
    difference() {
        // Connector
        translate([0, 0, -(connector_thickness/2)])
        cube([100, pillar_size, connector_thickness], center = true);
    
        // Connector holes
        draw_connector_holes();
    }
}

module draw_connector_holes() {
    translate([-(connector_hole_distance/2), 0, 0])
    cylinder(h=100, r=(connector_hole_diameter/2), center=true);
    
    translate([(connector_hole_distance/2), 0, 0])
    cylinder(h=100, r=(connector_hole_diameter/2), center=true);
}

module draw_connectors() {
    for (z=[0:90:270]) rotate_copy([0, 0, z])
    translate([0, 50-(pillar_size/2), 0])
    draw_a_connector();
}

module rotate_copy(vector) {
    children();
    rotate(vector) children();
}