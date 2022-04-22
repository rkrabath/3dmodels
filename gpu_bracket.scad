$fn=200;

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



module triangle(side1, side2, thickness){
    hyp = sqrt(side1*side1 + side2*side2);
    angle = asin(side2/hyp);

    rotate([0,90,-90])
        translate([-side1,0,-thickness])
            difference(){
                cube([side1, side2, thickness]);
                translate([0,0,-.001])
                    rotate([0,0,angle])
                        cube([hyp, hyp, thickness+.002]);
            }
}


module frame(){
    height = 50;
    base =  20;
    thickness = 5;
    
    
    hyp = sqrt(pow(height,2) + pow(base,2));
    main_incircle_radius = (height * base) / (height+base+hyp) * .85;
    main_incircle_point = incenter_point([0, height, 0], [base, 0, 0], [0,0,0]);
    echo(main_incircle_point);
    point = [main_incircle_point.x, -.001, main_incircle_point.y];
    difference(){
        triangle(height, base, thickness);  // TODO:  This should be a flange, not a triangle.  Inscribe an oval instead of a rotated square!
        
        translate(point)
            rotate([-90,0,0])
                cylinder(r=main_incircle_radius, h=thickness+.002);
    }
}

//assembly_post(5, 5.4);
//assembly_socket(5, 5.4);
translate([-50,20,120])
top_bracket();
translate([50,-20,-10])
bottom_bracket();
//translate([-45,17.5,-5])
//strut(8, 50);
translate([-30, 12.5,120])
rotate([0,180,0])
frame();


function incenter_point(A,B,C) = 
    let(
        a = norm(B-C),
        b = norm(A-C),
        c = norm(A-B),
        p = a + b + c,
        Ox = (a * A.x + b * B.x + c * C.x) / p,
        Oy = (a * A.y + b * B.y + c * C.y) / p,
        Oz = (a * A.z + b * B.z + c * C.z) / p
    )
[Ox, Oy, Oz];


function bezier4(points) =
let (s = 1.0 / $fn)
[for(t = 0, i = 0; i < $fn + 1; t = t + s, i = i + 1)
       (pow(1 - t, 3)             * points[0])
+  (3 * pow(1 - t, 2) * pow(t, 1) * points[1])
+  (3 * pow(1 - t, 1) * pow(t, 2) * points[2])
+  (                    pow(t, 3) * points[3])
];

module plot2d(points, size) {
  for(point = points) {
    translate(concat(point, 0))
      circle(r = size);
  }
}

points = bezier4([[0,0],[-50,-50],[100,-100],[0,-150]]);
//plot2d(points, 4);

module card(){
    cube([12.5,43.5,1]);
    translate([11.5,0,-121])
        cube([1,38,121]);
    translate([12.5,13,7.5-98])
        cube([156+29,25,98]);
    translate([35.5+12.5,25+11,-105])
        cube([112,2,15]);
}

card();

