module snowman(jauntiness = 0) {
    // the snowman's body
    translate([0, 0, 50]) sphere(r = 50);
    // the snowman's head
    translate([0, 0, 120]) sphere(r = 25);
    

    // the snowman's hat
    translate([0, 0, 120]) rotate([0, jauntiness, 0]) {
        translate([0, 0, 15]) {
          cylinder(r = 30, h =  2);
          cylinder(r1 = 20, r2 = 25, h =  40);
        }
    }
    // A carrot
    translate([0, -25, 120]) rotate([90, 0, 0]) cylinder(r1 = 5, r2 = 0, h = 20);
}

snowman(jauntiness = 30);
