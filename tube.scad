$fa = 1;
$fs = 0.4;

length = 100;
pipe_id = 10;
pipe_od = 13;

module fin(width, length, origin=[0,0,0]) {
    cutout_offset = length/2;
    implicit_offset = [length/2-.05, 0, -length/2+.001];
    offset = origin + implicit_offset;

    translate(offset){
        difference(){
            cube([length+.05,width,length], center=true);
            translate([cutout_offset,0,-cutout_offset])
                rotate([270,0,0])
                    cylinder(r=length, h=width + .001, center=true);
        }
        // TODO:  Accomodate extra camfer so fins reach the edge of the flange
    }
}
module flange(thickness, id, od, location) {
    bolt_offset = [(od - id) / 2 + id, 0, -2.001];
    //bolt_location = location + bolt_offset;
    
    translate(location) {
            difference() {
                // Flange with hole through the middle
                difference() {
                    union() {
                        cylinder(r=od, h=thickness);
                        mirror([0,0,1])
                            translate([0,0,-.001])
                                cylinder(r1=od, r2=id, h=2);
                    }
                    translate([0,0,-2.001])
                        cylinder(r=id, h=thickness+.002+2);
                }
                // Screw Holes
                union() {
                    for (angle=[0:90:270]){
                        rotate(angle)
                            translate(bolt_offset)
                                cylinder(r=3, h=thickness+2.002);
                        // TODO:  Provide for bolt holes
                    }
                }
        }
        // Fins
        for (angle=[22.5:45:360])
            rotate(angle)
                fin(2, od-id, [id,0,-0]);

    }
}


module steampunk_pipe(id, od, length){
    difference() {
        cylinder(r=od, h=length, center=true);
        cylinder(r=id, h=length+.001, center=true);
    }
    
    flange_radius = od * 2;
    flange_thickness = od - id;
    flange_location = [0,0,length/2-flange_thickness];
    for (side=[0:1:1]) {
        mirror ([0,0,side]) {
            flange(flange_thickness, od-.001, flange_radius, flange_location);
        }
    }
}


steampunk_pipe(pipe_id, pipe_od, length);


