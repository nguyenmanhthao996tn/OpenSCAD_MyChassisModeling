$fn=100;

/*** GLOBAL VARIABLES ***/
// The pillar
pillar_size = 8.5;
pillar_z = 18;
pillar_z_offset = 8.5;

// The pillar HOLES
pillar_hole_offset = -5.5;
pillar_hole_diameter = 3.05; // M2.5 with tapping

// The connector
connector_size = 7;
connector_thickness = 2.5;

// The connector HOLES
connector_hole_distance = 58;
connector_hole_diameter = 3.05; // M2.5 with tapping

// The vertical support
vertical_support_thickness = 1.5;
vertical_support_width = 18;
vertical_support_hole_diameter = 3.05; // M2.5 with tapping
vertical_support_holes_distance1 = 73;
vertical_support_holes_distance2 = 58;

/*** MAIN ***/
//color("#0000AF")
//render()
draw_chassis();

/*** FUNCTION DEFINE ***/

module draw_chassis() {
    union() {
        draw_connectors();
        draw_pillars();
        draw_vertical_supports();
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
        // draw_pillar_holes();
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
        cube([100, connector_size, connector_thickness], center = true);
    
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
    translate([0, 50-(connector_size/2), 0])
    draw_a_connector();
}

module draw_vertical_supports() {
    difference() {
        // Vertical support body
        for (i=[0:1:3])
        rotate([0, 0, 90*i])
        mirror_copy([0, 1, 0])
        draw_a_vertical_support_body();
        
        // Vertical support holes
        for (i=[0:1:3])
        rotate([0, 0, 90*i])
        mirror_copy([0, 1, 0])
        draw_a_vertical_support_hole();
    }
    
}

module draw_a_vertical_support_body() {
    translate([50-(vertical_support_thickness/2), -50+(vertical_support_width/2)+pillar_size, -(pillar_z - pillar_z_offset)/2])
    cube([vertical_support_thickness, vertical_support_width, (pillar_z - pillar_z_offset)], center=true);
}

module draw_a_vertical_support_hole() {
    translate([0, -(vertical_support_holes_distance1/2), -5])
    rotate([0, 90, 0])
    cylinder(h=500, d=vertical_support_hole_diameter, center=true);
    
    translate([0, -(vertical_support_holes_distance2/2), -5])
    rotate([0, 90, 0])
    cylinder(h=500, d=vertical_support_hole_diameter, center=true);
}

module rotate_copy(vector) {
    children();
    rotate(vector) children();
}

module mirror_copy(vector) {
    children();
    mirror(vector) children();
}