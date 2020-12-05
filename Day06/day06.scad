use <day05.scad>
use <snowman.scad>


// Make a 'cake' with footprints in it
 difference() {
     // The cake itself is just a cylinder
     cylinder(r = 200, h = 100);
     
     // The footprints are steps around the centre. Let's have 18 steps
     for(step = [0 : 1 : 18]) {
         // if there are 18 steps, each one is one twentieth of 360 degrees.
         // so let's rotate by that amount
         rotate([0, 0, 20 * step])
            // The steps are around the outside of the cake:
            // let's move to somewhere near the edge for our walking line
            translate([-170, 0, 96])
                // Now, it's either a left or right foot - decide which
                mirror([step % 2 == 1 ? 1 : 0, 0, 0])
                    // and place our footprint
                    translate([- 10, 0, 0]) sole();
    }
}

// Pop our snowman on the top
translate([0, 0, 95]) snowman(jauntiness = 15);