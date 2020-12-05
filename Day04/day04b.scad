module crystal(length = 20, thickness = 1) {
    sizes = [5, 10, 1, 5, 2];
    
    // Draw our first cuboid, centre it on the plane X = 0
    translate([-thickness / 2, 0, 0]) cube([thickness, length, thickness]);

    // Now draw our other cuboids at intervals along the first
    // We want to loop over 5 steps (because we have 5 sizes above)
    for(step = [0:4])
        // With each step, we want an original and a mirrored version
        for(mirror_x = [0,1])
            // Move to the step position (which is one fifth of the length) times the step count
            // Note: OpenSCAD starts counting at 0 for vectors, so we add one to the step
            translate([0, (length / 5) * (step + 1), 0])
                // Mirror (or don't, depending on whether this is the original or the mirrored version)
                mirror([mirror_x, 0, 0])
                    // Rotate 30 degrees around the Z axis
                    rotate([0, 0, 30]) {
                        new_length = (length / 20) * sizes[step];
                        // And draw a section with the length for this step
                        if (new_length > 10) {
                            crystal(length = new_length);
                        } else {
                            translate([-thickness / 2, 0, 0])
                                cube([thickness, new_length, thickness]);
                        }
                    }
}

for(a = [0 : 60 : 360])
    rotate([0, 0, a])
        crystal(length = 200);