$fn=100;

use <components.scad>

width_of_mounting_screws = 2.3;


module top_bracket(){
    // Top bracket
    depth_of_bracket = 20;
    depth_of_mounting_hole = 9;
    width_of_bracket = 44;

    screw_x = depth_of_bracket - depth_of_mounting_hole;
    screw_1_location = [screw_x, 9.9+3.2, -.01];
    screw_2_location = [screw_x, 30.1+3.2, -.01];
    screw_3_location = [screw_x+4.4, 16.5+3.2, -.01];
    screw_4_location = [screw_x+4.4, 34.7+3.2, -.01];
    difference(){
        cube([depth_of_bracket, width_of_bracket, 5.4]);
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
    translate([-5,-5+.01,0])
        assembly_socket(5, 5.4);
    translate([5,-5+.01,0])
        assembly_socket(5, 5.4);
    translate([15,-5+.01,0])
        assembly_socket(5, 5.4);
    translate([-5, 49-.01, 0])
        assembly_socket(5, 5.4);
    translate([5,49-.01,0])
        assembly_socket(5, 5.4);
    translate([15,49-.01,0])
        assembly_socket(5, 5.4);
}





//translate([-40,17,121])  card();

translate([-50,17,115])  top_bracket();

difference(){
    union(){
//        translate([-35, 17, 0])
//            bottom_front_bracket();
//        translate([35, 17, 0])
//            bottom_middle_bracket();
//        translate([102, 17, 0])
//            bottom_back_bracket();
    }
//    translate([-10-.001-4.5,42+.02,5+.01])  bottom_mounting_plate();
    
}

