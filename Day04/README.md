# Day 4
Today we're going to look at:
 - Mirrors, and
 - Modules that use... themselves

## Mirrors

Create a new, empty OpenSCAD file (say, `day04.scad`) and save it.

Now enter this...

``` OpenSCAD
// Some text
linear_extrude(3, $fn = 30) text("Hacky Christmas!");
```

... and press F5 / Preview. Zoom / pan around a bit in the right hand pane and you'll see a message in 3D text.

`linear_extrude` is a feature that allows you to extrude (stretch, if you like) a 2D shape to make a 3D one.

Now, change the program to read:

``` OpenSCAD
// Some mirrored text
for (y = [0, 1]) {
    mirror([0, y, 0]) linear_extrude(3, $fn = 30) text("Hacky Christmas!");
}
```

F5 / Preview again, and you'll see we made some mirrored text. Cool!

The `for` loop here is a bit different to the one we used on day 1; here, we're looping through a set of values (in this case, just `0` and `1`). I'm using the `for` loop so I don't have to repeat the code just because I'm mirroring; first `y` is `0`, then `1`. This means that when `mirror` is first used, it's used with values `[0, 0, 0]` (no mirroring on X, Y or Z) and the second time it's used, it's used with values `[0, 1, 0]` (mirroring on the Y axis only).

We can use `mirror` on any shape in OpenSCAD. Let's use it to make something else christmas-y.

Delete the code in the `day04.scad` file, we're going to replace it with something else; I want to make some cuboids. Remember how we use `cylinder` for things that aren't cylinders (like cones)? Well, we can use `cube` to make things that aren't cubes (like cuboids)...

So what I want to do is have a long cuboid with a couple of little cuboids coming out of both of the sides... at intervals.

Something like this:

``` OpenSCAD
// more mirroring
thickness = 1;
length = 20;
sizes = [3, 4, 6, 3, 0];

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
                rotate([0, 0, 30])
                    // And draw a cuboid of the length for this step (centred)
                    translate([-thickness / 2, 0, 0])
                        cube([thickness, sizes[step], thickness]);
```

Notice here that I've included comments in the code explaining what each line is doing. I'll do that in these exercises from this point on.

F5 / Preview. And you'll see we have a symmetrical shape. Looks a bit like a tree or something.

## Modules that use themselves

Now we're going to put that shape in a module (remember this from day 2) and make a couple of changes to make sure that length of both the big cuboid and the little cuboids can be scaled (using the `length` parameter).

The code now looks like this...

```OpenSCAD
module crystal(length = 20) {
    sizes = [3, 4, 6, 3, 0];

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
                    rotate([0, 0, 30])
                        // And draw a cuboid of the length for this step (centred)
                        translate([-thickness / 2, 0, 0])
                            cube([thickness, (length / 20) * sizes[step], thickness]);
}

crystal();
```

F5 / Preview. Should look pretty much the same as before.

Here's where it gets interesting. We're going to make two changes to this program:

Firstly, change the line that reads `crystal();` to `crystal(length = 100);`

Now change the section that reads

```OpenSCAD
                    rotate([0, 0, 30])
                        // And draw a cuboid of the length for this step (centred)
                        translate([-thickness / 2, 0, 0])
                            cube([thickness, (length / 20) * sizes[step], thickness]);
```

to

``` OpenSCAD
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
```

Notice that we've created a new variable `new_length` to store the length of the next part... and that the next part can either be the cuboid we used before or another crystal...

F5 / Refresh.

Can you see where this is going now?


Finally, let's replace the line that reads

```OpenSCAD
crystal(length = 100);
```

to

```OpenSCAD
for(a = [0 : 60 : 360])
    rotate([0, 0, a])
        crystal(length = 200);
```

F5 / Refresh, then choose "view -> view all" from the menu - and hopefully you see a snowflake (if not, my version of the code for today is [here](day04.scad))