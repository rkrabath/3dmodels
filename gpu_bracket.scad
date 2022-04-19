$fn=100;

width_of_mounting_screws = 2.3; // TODO: Measure mounting screws


module assembly_post(width, depth){
    base_dim = width+5;
    base_thickness = 1;
    translate([0,0,depth/2])
        cube([width,width,depth], center=true);
    translate([-base_dim/2,-base_dim/2,-base_thickness+ .001])
       cube([base_dim,base_dim,base_thickness]);
    
}

module assembly_socket(width, depth){
    translate([0,0,depth/2])
        difference(){
            cube([width+5,width+5,depth], center=true);
            cube([width, width, depth+.001], center=true);
        }

}




module top_bracket(){
    // Top bracket
    depth_of_bracket = 20;
    depth_of_mounting_hole = 9;

    screw_1_location = [depth_of_bracket - depth_of_mounting_hole,9.9,-.001];
    screw_2_location = [depth_of_bracket - depth_of_mounting_hole,30.1,-.001];
    screw_3_location = [depth_of_bracket - depth_of_mounting_hole+4.4,16.5,-.001];
    screw_4_location = [depth_of_bracket - depth_of_mounting_hole+4.4,34.7,-.001];
    difference(){
        cube([depth_of_bracket, 39.4, 5.4]);
        union() {
            translate(screw_1_location)
                cylinder(r=width_of_mounting_screws, h=5.5);
            translate(screw_2_location)
                cylinder(r=width_of_mounting_screws, h=5.5);
            translate(screw_3_location)
                cylinder(r=width_of_mounting_screws, h=5.5);
            translate(screw_4_location)
                cylinder(r=width_of_mounting_screws, h=5.5);
        }
    }
    
    // Assembly sockets
    translate([5,-5+.001,0])
        assembly_socket(5, 5.4);
    translate([15,-5+.001,0])
        assembly_socket(5, 5.4);
    translate([5,44.4-.001,0])
        assembly_socket(5, 5.4);
    translate([15,44.4-.001,0])
        assembly_socket(5, 5.4);
}

module bottom_bracket(){
    width_of_mounting_plate = 12;
    length_of_mounting_plate = 140;
    wall_thickness = 6;
    outer_dims = [
        length_of_mounting_plate + 2*wall_thickness,
        width_of_mounting_plate + 2*wall_thickness,
        10
    ];
    
    difference() {
        cube(outer_dims);
        union() {
            // Mounting plate cut-out
            translate([5,6,5+.001])
                cube([length_of_mounting_plate, width_of_mounting_plate, 5]);
            translate([22,18-.001,5.001])
                cube([102, 7.002, 5]);
            // screw holes
            translate([wall_thickness+5,6+width_of_mounting_plate/2,0-.001])
                cylinder(r=width_of_mounting_screws, h=10.001);
            translate([length_of_mounting_plate+wall_thickness-6-5,6+width_of_mounting_plate/2,0-.001])
                cylinder(r=width_of_mounting_screws, h=10.001);
        }
    }
}


module strut(thickness, height){
    cube([thickness, thickness, height], center=true);
    translate([0,0,height/2])
    assembly_post(5, 5);
    translate([0,0,-height/2])
    rotate([180,0,0])
    assembly_post(5, 5);
}


//assembly_post(5, 5.4);
//assembly_socket(5, 5.4);
translate([-50,20,20])
top_bracket();
bottom_bracket();
//translate([-45,17.5,-5])
//strut(8, 50);




