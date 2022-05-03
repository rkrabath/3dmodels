$fn=100;

use <components.scad>

width_of_mounting_screws = 2.3; // TODO: Measure mounting screws


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



//translate([-40,17,121])  card();


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

