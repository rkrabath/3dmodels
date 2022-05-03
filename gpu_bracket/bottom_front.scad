$fn=100;

use <components.scad>

width_of_mounting_screws = 2.3; // TODO: Measure mounting screws


module bottom_front_bracket(){
    width_of_bracket = 44;

    difference(){
        cube([50,width_of_bracket,12]);
        union(){

            
            // Mounting holes for screws
            translate([17,37,-8.01]){
                rotate([0,0,30])translate([0,0,15])cylinder(r=width_of_mounting_screws+3, h=15.02 );
                cylinder(r=width_of_mounting_screws, h=30.02);
            }
            translate([17,15,-8.01]){
                rotate([0,0,30])translate([0,0,15])cylinder(r=width_of_mounting_screws+3, h=15.02 );
                cylinder(r=width_of_mounting_screws, h=30.02);
            }
            translate([36,15,-8.01]){
                rotate([0,0,30])translate([0,0,15])cylinder(r=width_of_mounting_screws+3, h=15.02 );
                cylinder(r=width_of_mounting_screws, h=30.02);
            }
        }
    }
    
    // Frame Sockets
    translate([2.5,-5,14.5]){
        translate([5,0,0])
            assembly_socket(5, 5.4);
        translate([15,0,0])
            assembly_socket(5, 5.4);
        translate([25,0,0])
            assembly_socket(5, 5.4);
    }
    // Support for sockets
    difference(){
        translate([2.5,0,14.5])
            rotate([90,0,0])
                rotate([0,0,-90])
                    triangle(10, 14.5, 30);
        union(){
            translate([7,-10,0])
                gothic_arch(5,5,5,30);
            translate([14,-10,0])
                gothic_arch(5,5,5,30);
            translate([21,-10,0])
                gothic_arch(5,5,5,30);
            translate([28,-10,0])
                gothic_arch(5,5,5,30);
        }
    }
    
    // Frame Sockets
    translate([2.5,49-.01,14.5]){
        translate([5, 0, 0])
            assembly_socket(5, 5.4);
        translate([15,0,0])
            assembly_socket(5, 5.4);
        translate([25,0,0])
            assembly_socket(5, 5.4);
    }
    // Support for sockets
    difference(){
        translate([2.5, 44,14.5])
            rotate([0,0,-90])
                rotate([0,180,0])
                    triangle(14.5, 10, 30);
    
        union(){
            translate([7,43,0])
                gothic_arch(5,5,5,30);
            translate([14,43,0])
                gothic_arch(5,5,5,30);
            translate([21,43,0])
                gothic_arch(5,5,5,30);
            translate([28,43,0])
                gothic_arch(5,5,5,30);
        }
    }

}



//translate([-40,17,121])  card();


difference(){
    union(){
        translate([-35, 17, 0])
            bottom_front_bracket();
//        translate([35, 17, 0])
//            bottom_middle_bracket();
//        translate([102, 17, 0])
//            bottom_back_bracket();
    }
    translate([-10-.001-4.5,42+.02,5+.01])  bottom_mounting_plate();
    
}

