module sole() {
    translate([-7, -10, 0]) cube([12, 8, 5]);

    difference() {
        // Translate to y=15
        translate([0, 15, 0])
            // Rotate a little (5 degrees clockwise around Z); you'll see why in a bit
            rotate([0, 0, -5])
                // Make an ellipse by squashing a 15mm radius circle in the X axis.
                scale([0.6, 1, 1])
                    cylinder(r = 15, h = 5);
        translate([-8, 0, -1]) cube([16, 5, 7]);
    }
}

module footprints() {
    difference() {
        // snow
        color("white")
            translate([-100, 0, -6]) cube([200, 1200, 10]);

        // footprints in the snow
        for(i = [0 : 20]) {
            mirror([i % 2 == 1 ? 1 : 0, 0, 0])
            translate([-10, 60 * i, 0]) sole();
        }
    }
}

// sole();

footprints();

//difference() {
//    cube([20, 20, 5]);
//    cylinder(r = 20, h = 5);
//}