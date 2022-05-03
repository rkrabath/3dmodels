$fn=100;

use <components.scad>

width_of_mounting_screws = 2.3; // TODO: Measure mounting screws




//translate([-40,17,121])  card();

translate([-50,17,115])  top_bracket();

difference(){
    union(){
        translate([-35, 17, 0])
            bottom_front_bracket();
        translate([35, 17, 0])
            bottom_middle_bracket();
        translate([102, 17, 0])
            bottom_back_bracket();
    }
    translate([-10-.001-4.5,42+.02,5+.01])  bottom_mounting_plate();
    
}

translate([-30, 9.2,115])
rotate([180,0,180])
frame(30,80,5);
translate([-30-2,9.2,20])
frame(50,90,5);

//translate([70,100,-63.5])rotate([90,0,0]){
translate([0,51.1,0])
translate([-30, 12.5,115])
rotate([180,0,180])
frame(30,80,5);
translate([-2,51.1,0])
translate([-30,12.5,20])
frame(50,90,5);
//}



module card(){
    // screw plate
    cube([12.5,43.5,1]);
    // socket panel
    translate([11.5,0,-121])
        cube([1,38,121]);
    // main body
    translate([12.5,13,7.5-98])
        cube([156+29,32,98]);
    // pci connector
    translate([35.5+12.5,25+11,-105])
        cube([112,2,15]);
}
