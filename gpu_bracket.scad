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
    
    curve_height = height;
    curve_base = base*.9;
    points = [
        [curve_height*.01,0,curve_height],
        [curve_height*.01,0,curve_height*.75],
        [base*.25,0,curve_height*.11],
        [base,0,curve_height*.11]
    ];
    
    

        {
                        
            // Right angle bracket
            //translate([-1.5,height-.001,0])
                cube([base, thickness, height*.01]);
            //translate([-1.5,0,0])
                cube([height*.01, thickness, height]);
            
            // Bottom curve
    
            //plot3d(bezier4(points),height*.005,thickness);
            //translate([base*.1, 0, height*.1])
            line(bezier4(points), height*.01, thickness);
            
            
            // Distal ring
            ring_od = curve_height*.05;
            ring_id = ring_od - curve_height*.01;
            translate([base*.9, 0, ring_od+height*.01])
               rotate([-90,0,0])
                ring(ring_od, ring_id, thickness);
            
            main_icp_base = base*.75;
            main_icp_height = height*.75;
            a = [height*.01,0,height*.01];
            b = [main_icp_base,0,height*.01];
            c = [height*.01,0,main_icp_height];
            main_icp = incenter_point(a,b,c);
            hyp = sqrt(pow(main_icp_base,2) + pow(main_icp_height,2));
            main_od = (main_icp_height * main_icp_base) / (main_icp_height+main_icp_base+hyp);
            main_id = main_od - curve_height*.01;
            translate(main_icp)rotate([-90,0,0])ring(main_od, main_id, thickness);
        }

       
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
        translate([0,0,-.001])
            cylinder(r=id, h=length+.002);
    }
}



//translate([-50,20,120])  top_bracket();

//translate([50,-20,-10])  bottom_bracket();



//translate([-30, 12.5,70])
//rotate([0,180,0])
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

module plot3d(points, width, length) {
  for(point = points) {
    translate(concat(point, 0))
      cylinder(r = width, h=length);
  }
}



module card(){
    cube([12.5,43.5,1]);
    translate([11.5,0,-121])
        cube([1,38,121]);
    translate([12.5,13,7.5-98])
        cube([156+29,25,98]);
    translate([35.5+12.5,25+11,-105])
        cube([112,2,15]);
}


//translate([0,500,110])  card();



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
