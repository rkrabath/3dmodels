$fn=100;

width_of_mounting_screws = 2.3; // TODO: Measure mounting screws


module assembly_post(width, depth){
    base_dim = width+5;
    base_thickness = 1;
    translate([0,0,depth/2])
        cube([width,width,depth], center=true);
 //   translate([-base_dim/2,-base_dim/2,-base_thickness+ .001])
 //      cube([base_dim,base_dim,base_thickness]);
    
}

module assembly_socket(width, depth){
    translate([0,0,depth/2])
        difference(){
            cube([width+5,width+5,depth], center=true);
            cube([width, width, depth+.01], center=true);
        }

}




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

module bottom_mounting_plate(){
    width_of_mounting_plate = 12;
    length_of_mounting_plate = 140;
    wall_thickness = 6;
 
    
    union() {
        // Mounting plate cut-out
        translate([5,6,5+.001])
            cube([length_of_mounting_plate, width_of_mounting_plate, 5]);
        translate([24,6,5+.001])
            cube([length_of_mounting_plate-38, width_of_mounting_plate+2, 3]);
        translate([26,19-.01,5.01-2.25])
            cube([95, 12.3, 10]);
        translate([31,6,5-2.001])
            cube([90,10,7]);
        // screw holes
        translate([wall_thickness+5,6+width_of_mounting_plate/2,-20.001])
            cylinder(r=width_of_mounting_screws-.4, h=30.001);
        translate([length_of_mounting_plate+wall_thickness-6-5,6+width_of_mounting_plate/2,-20.001])
            cylinder(r=width_of_mounting_screws-.4, h=30.001);
        // Front Flange
    translate([-14.01,-22.02,-5.01])
                        cube([1, 38, 30]);

    }
    
}

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


module bottom_back_bracket(){
    width_of_bracket = 44;

    difference(){
        translate([5,0,0])
        cube([50,width_of_bracket,12]);
        union(){
            translate([20,15,-8.01]){
                rotate([0,0,30])translate([0,0,15])cylinder(r=width_of_mounting_screws+3, h=15.02);
                cylinder(r=width_of_mounting_screws, h=30.02);
            }
            translate([44,15,-8.01]){
                rotate([0,0,30])translate([0,0,15])cylinder(r=width_of_mounting_screws+3, h=15.02);
                cylinder(r=width_of_mounting_screws, h=30.02);
            }
            translate([44,37,-8.01]){
                rotate([0,0,30])translate([0,0,15])cylinder(r=width_of_mounting_screws+3, h=15.02);
                cylinder(r=width_of_mounting_screws, h=30.02);
            }
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
                translate([0,0,-.01])
                    rotate([0,0,angle])
                        cube([hyp, hyp, thickness+.02]);
            }
}


module frame(base=20, height=50, width=5){
    
    thickness = max(3,height*.02);
    
    curve_height = height;
    curve_base = base*.9;
    points = [
        [thickness,0,curve_height],
        [thickness,0,curve_height*.75],
        [base*.25,0,curve_height*.1 + thickness],
        [base,0,curve_height*.1+thickness]
    ];
    
    // Right angle bracket
    cube([base, width, thickness]);
    cube([thickness, width, height]);
    
    // Bottom curve
    line(bezier4(points), thickness, width);
    
    
    // Distal ring
    ring_od = (points[3].z/2)-thickness/2;
    ring_id = ring_od - thickness;
    translate([base*.9, 0, ring_od+thickness*.9])
       rotate([-90,0,0])
        ring(ring_od, ring_id, width);

    // Central ring
    even_ratio = base*2 < height ? true : false;
    main_icp_base = base*.75-thickness;
    main_icp_height = height*.75-thickness;
    off_set = even_ratio ? 0 : -thickness;
    a = [off_set,0,off_set];
    b = [main_icp_base,0,off_set];
    c = [off_set,0,main_icp_height];
    main_icp = incenter_point(a,b,c);
    hyp = sqrt(pow(main_icp_base,2) + pow(main_icp_height,2));
    od = (main_icp_height * main_icp_base) / (main_icp_height+main_icp_base+hyp) + thickness/2;
    main_od = even_ratio ? od : od-1;
    main_id = main_od - thickness;
    translate(main_icp)
        translate([thickness, 0, thickness])
            rotate([-90,0,0])
                ring(main_od, main_id, width);
    //rotate([-90,0,0])            
    
    // Rounded endcaps
    cap_diam = thickness*1.35;
    translate([0,width,height])
    rotate([90,180,0])
    {
        difference(){
            cylinder(h=width, r=cap_diam);
        
            union(){
                translate([-width,0,-.005])
                    cube([width*2+.01, width*2+.01, width*2+.01]);
                translate([0,-width,-.005])
                    cube([width+.01, width+.01, width+.01]);
            }
        }
    }
    
    // Attachment Studs
    
    translate([5,2.5,-5])
    assembly_post(4.8,5.4-.001);
    translate([15,2.5,-5])
    assembly_post(4.8,5.4-.001);
    translate([25,2.5,-5])
    assembly_post(4.8,5.4-.001);
}


module line(points, thickness, width) {
    
    translate([0,width,0])
        rotate([90,0,0])
            linear_extrude(height=width)
                projection()
                    rotate([-90,0,0])
                    {
                    for(i=[0:len(points)-1]){
                        j = i + 1;
                        v = str(points[j]) == "undef" ? points[i-1] - points[i] : points[i] - points[j];
                        translate(points[i])
                            multmatrix(rotate_from_to([0,0,1],v))
                                rotate([0,0,45])
                                cylinder(d=thickness, h=norm(v)+.001, $fn=4);
                    }
                    }
}


module ring(od, id, length){
    difference()
    {
        cylinder(r=od, h=length);
        translate([0,0,-.01])
            cylinder(r=id, h=length+.02);
    }
}




//translate([-40,17,121])  card();

//translate([-50,17,115])  top_bracket();

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

//translate([-30, 9.2,115])
//rotate([180,0,180])
//frame(30,80,5);
//translate([-30-2,9.2,20])
//frame(50,90,5);

translate([70,100,-63.5])rotate([90,0,0]){
translate([0,51.1,0])
translate([-30, 12.5,115])
rotate([180,0,180])
frame(30,80,5);
translate([-2,51.1,0])
translate([-30,12.5,20])
frame(50,90,5);
}



module gothic_arch(width=20, straight_height=30, curve_height=30, depth=5){
    
    thickness = max(2,straight_height*.01);
    
    
    curve_width = width/2;
    points = [
        [0,0,0],
        [0,0,curve_height*.75],
        [curve_width,0,curve_height],
        [curve_width+.1,0,curve_height]
    ];
    
    translate([0,0,straight_height])
        hull(){
            translate([-width/2,0,0])
            line(bezier4(points), 1, depth);
            mirror([1,0,0])translate([-width/2,0,0])
            line(bezier4(points), 1, depth);
        }
    translate([0,depth/2,straight_height/2])
    cube([width+.7, depth, straight_height], center=true);
}



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

module plot3d(points, width, length) {
  for(point = points) {
    translate(concat(point, 0))
      cylinder(r = width, h=length);
  }
}



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





// Find the unitary vector with direction v. Fails if v=[0,0,0].
function unit(v) = norm(v)>0 ? v/norm(v) : undef; 
// Find the transpose of a rectangular matrix
function transpose(m) = // m is any rectangular matrix of objects
  [ for(j=[0:len(m[0])-1]) [ for(i=[0:len(m)-1]) m[i][j] ] ];
// The identity matrix with dimension n
function identity(n) = [for(i=[0:n-1]) [for(j=[0:n-1]) i==j ? 1 : 0] ];

// computes the rotation with minimum angle that brings a to b
// the code fails if a and b are opposed to each other
function rotate_from_to(a,b) = 
    let( axis = unit(cross(a,b)) )
    axis*axis >= 0.99 ? 
        transpose([unit(b), axis, cross(axis, unit(b))]) * 
            [unit(a), axis, cross(axis, unit(a))] : 
        identity(3);
