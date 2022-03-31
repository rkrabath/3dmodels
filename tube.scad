$fa = 1;
$fs = 0.4;

length = 100;
pipe_id = 10;
pipe_od = 13;

module flange(thickness, id, od, location) {
    bolt_offset = [(od - id) / 2 + id, 0, 0-.001];
    bolt_location = location + bolt_offset;
    

    translate(location) {
        difference() {
            difference() {
                cylinder(r=od, h=thickness);
                translate([0,0,-.001])
                    cylinder(r=id, h=thickness+.002);

            }
            union() {
                rotate(90)
                    translate(bolt_offset)
                        cylinder(r=3, h=thickness+.002);
                rotate(180)
                    translate(bolt_offset)
                        cylinder(r=3, h=thickness+.002);
                rotate(270)
                    translate(bolt_offset)
                        cylinder(r=3, h=thickness+.002);
                rotate(360)
                    translate(bolt_offset)
                        cylinder(r=3, h=thickness+.002);
            }
        }
    }
}

module steampunk_pipe(id, od, length){
    difference() {
        cylinder(r=od, h=length, center=true);
        cylinder(r=id, h=length+.001, center=true);
    }
    
    flange_radius = od * 2;
    flange(4, od-.001, flange_radius, [0,0,length/2-4]);
    flange(4, od-.001, flange_radius, [0,0,-length/2]);

}




steampunk_pipe(pipe_id, pipe_od, length);
    

