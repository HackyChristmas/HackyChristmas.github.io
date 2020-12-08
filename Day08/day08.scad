module custard(r = 40) {
    minkowski() {
        intersection() {
            linear_extrude(height = r + 0.5) import("splodge.dxf");
            sphere(r = r + 0.5);
        }
        sphere(r = 1);
    }
}

module pudding(r = 40, custard = true) {
    translate([0, 0, r]) {
        if (custard) {
            custard(r = r);
        }
        sphere(r = r);
    }
}

pudding();
