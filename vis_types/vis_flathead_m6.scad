$fn=100;

// M6
crew_head_diameter=(11.3+10.9)/2; // dk
crew_body_diameter=6;

screw_length=45;

// Head
translate([0, 0, -crew_head_diameter/2])
cylinder(h=crew_head_diameter/2,r1=0, r2=crew_head_diameter/2, center=false);

// Body
translate([0, 0, -screw_length])
cylinder(h=screw_length, d=crew_body_diameter, center=false);