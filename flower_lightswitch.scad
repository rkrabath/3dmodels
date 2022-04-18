//for(angle=[0:60:360])rotate(angle)translate([0,20,0])circle(r=10);

module teardrop(){
    hull() {
        sphere(r = 20);
        cylinder(h = 50, r1 = 5, r2 = 0);
}
}

module flat_teardrop(){
    projection()
        rotate([0,90,0])
            teardrop();
}

module flat_flower(){
    minkowski(){
        for(angle=[0:60:360])
            rotate(angle)
                translate([-40,0,0])
                    flat_teardrop();
        sphere(r=5);
    }
}

difference(){
    linear_extrude(10)
        flat_flower();
    // Cut outs
    union(){
        cube([16,8,21], center=true);
        for(angle=[0:180:359])
            rotate(angle)
        translate([20,0,0])
            cylinder(r=5, h=21, center=true);
    }
}