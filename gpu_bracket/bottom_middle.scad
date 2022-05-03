$fn=100;

use <components.scad>

width_of_mounting_screws = 2.3; // TODO: Measure mounting screws



module bottom_middle_bracket(){
    width_of_bracket = 44;

    difference(){
        cube([50,width_of_bracket,10]);
        union(){
            translate([15,15,-8.01]){
                rotate([0,0,30])translate([0,0,15])cylinder(r=width_of_mounting_screws+3, h=15.02);
                cylinder(r=width_of_mounting_screws, h=30.02);
            }
            translate([36,15,-8.01]){
                rotate([0,0,30])translate([0,0,15])cylinder(r=width_of_mounting_screws+3, h=15.02);
                cylinder(r=width_of_mounting_screws, h=30.02);
            }
        }
    }
}



//translate([-40,17,121])  card();


difference(){
    union(){
//        translate([-35, 17, 0])
//            bottom_front_bracket();
        translate([35, 17, 0])
            bottom_middle_bracket();
//        translate([102, 17, 0])
//            bottom_back_bracket();
    }
    translate([-10-.001-4.5,42+.02,5+.01])  bottom_mounting_plate();
    
}

