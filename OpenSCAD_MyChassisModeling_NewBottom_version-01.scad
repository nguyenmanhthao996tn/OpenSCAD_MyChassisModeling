$fn=128;

/*** GLOBAL VARIABLES ***/
// The pillar
pillar_size = 8.5;
pillar_z = 18;
pillar_z_offset = 8.5;

// The pillar HOLES
pillar_hole_offset = -5.5;
pillar_hole_diameter = 2.05; // M2.5 with tapping

// The connector
connector_size = 7;
connector_thickness = 2.5;

// The connector HOLES
connector_hole_distance = 58;
connector_hole_diameter = 2.05; // M2.5 with tapping

// The vertical support
vertical_support_thickness = 1.5;
vertical_support_width = 18;
vertical_support_hole_diameter = 2.05; // M2.5 with tapping
vertical_support_holes_distance1 = 73;
vertical_support_holes_distance2 = 58;
vertical_support_holes_deep = 10;

// Cutout for cable
cable_cutout_gap_width = 2;
cable_cutout_gap_length = 20;

/*** MAIN ***/
//color("#0000AF")
//render()
draw_chassis();

/*** FUNCTION DEFINE ***/

module draw_chassis() {
    difference() {
        union() {
            draw_pillars();
            draw_solid_supports();
        }
        
        // Fixing vis
        translate([0, 0, -(pillar_z-pillar_size)])
        rotate([180, 0, 0])
        vis_type_m10(45);
        
        // Cutout for cable
        union() {
            translate([100-cable_cutout_gap_length, 0, 0])
            cube([100, cable_cutout_gap_width, 100], center=true);

            rotate([0, 0, 90])
            translate([100-cable_cutout_gap_length, 0, 0])
            cube([100, cable_cutout_gap_width, 100], center=true);

            rotate([0, 0, 180])
            translate([100-cable_cutout_gap_length, 0, 0])
            cube([100, cable_cutout_gap_width, 100], center=true);

            rotate([0, 0, 270])
            translate([100-cable_cutout_gap_length, 0, 0])
            cube([100, cable_cutout_gap_width, 100], center=true);
        }
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

module draw_solid_supports() {
    difference() {
        translate([0, 0, -((pillar_z-pillar_z_offset)/2)])
        cube([100, 100, (pillar_z-pillar_z_offset)], center=true);
        
        // Vertical support holes
        for (i=[0:1:3])
        rotate([0, 0, 90*i])
        mirror_copy([0, 1, 0])
        draw_a_vertical_support_hole();
        
        // Outside vertical holes
        for (z=[0:90:270]) rotate_copy([0, 0, z])
        translate([0, 50-(connector_size/2), 0]) {
            translate([-(connector_hole_distance/2), 0, 0])
            cylinder(h=100, r=(connector_hole_diameter/2), center=true);

            translate([(connector_hole_distance/2), 0, 0])
            cylinder(h=100, r=(connector_hole_diameter/2), center=true);
        }
        
        // Inside vertical holdes
        for (z=[0:90:270]) rotate_copy([0, 0, z])
        translate([0, 35, 0]) {
            translate([-(connector_hole_distance/2)+15, 0, 0])
            cylinder(h=100, r=(connector_hole_diameter/2), center=true);
            
            translate([(connector_hole_distance/2)-15, 0, 0])
            cylinder(h=100, r=(connector_hole_diameter/2), center=true);
        }
    }
    
}

module draw_a_vertical_support_body() {
    translate([50-(vertical_support_thickness/2), -50+(vertical_support_width/2)+pillar_size, -(pillar_z - pillar_z_offset)/2])
    cube([vertical_support_thickness, vertical_support_width, (pillar_z - pillar_z_offset)], center=true);
}

module draw_a_vertical_support_hole() {
    translate([50-(vertical_support_holes_deep/2)+1, -(vertical_support_holes_distance1/2), -5])
    rotate([0, 90, 0])
    cylinder(h=vertical_support_holes_deep+1, d=vertical_support_hole_diameter, center=true);
    
    translate([50-(vertical_support_holes_deep/2)+1, -(vertical_support_holes_distance2/2), -5])
    rotate([0, 90, 0])
    cylinder(h=vertical_support_holes_deep+1, d=vertical_support_hole_diameter, center=true);
}

module rotate_copy(vector) {
    children();
    rotate(vector) children();
}

module mirror_copy(vector) {
    children();
    mirror(vector) children();
}

// VIS / SCREW

module vis_type_m10(screw_length) {
    // M10
    crew_head_diameter=(18.3+17.8)/2; // dk
    crew_body_diameter=10;

    union() {
        // Head
        translate([0, 0, -crew_head_diameter/2])
        cylinder(h=crew_head_diameter/2,r1=0, r2=crew_head_diameter/2, center=false);
        cylinder(h=0.5,d=crew_head_diameter, center=false);

        // Body
        translate([0, 0, -screw_length])
        cylinder(h=screw_length, d=crew_body_diameter, center=false);
    }
}

module vis_type_m8(screw_length) {
    // M8
    crew_head_diameter=(15.8+15.4)/2; // dk
    crew_body_diameter=8;

    union() {
        // Head
        translate([0, 0, -crew_head_diameter/2])
        cylinder(h=crew_head_diameter/2,r1=0, r2=crew_head_diameter/2, center=false);
        cylinder(h=0.5,d=crew_head_diameter, center=false);

        // Body
        translate([0, 0, -screw_length])
        cylinder(h=screw_length, d=crew_body_diameter, center=false);
    }
}

module vis_type_m6(screw_length) {
    // M6
    crew_head_diameter=(11.3+10.9)/2; // dk
    crew_body_diameter=6;

    union() {
        // Head
        translate([0, 0, -crew_head_diameter/2])
        cylinder(h=crew_head_diameter/2,r1=0, r2=crew_head_diameter/2, center=false);
        cylinder(h=0.5,d=crew_head_diameter, center=false);

        // Body
        translate([0, 0, -screw_length])
        cylinder(h=screw_length, d=crew_body_diameter, center=false);
    }
}