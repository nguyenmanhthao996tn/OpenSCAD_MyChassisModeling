$fn=100;

// M10
crew_head_diameter=(18.3+17.8)/2; // dk
crew_body_diameter=10;

screw_length=45;

// Head
translate([0, 0, -crew_head_diameter/2])
cylinder(h=crew_head_diameter/2,r1=0, r2=crew_head_diameter/2, center=false);

// Body
translate([0, 0, -screw_length])
cylinder(h=screw_length, d=crew_body_diameter, center=false);