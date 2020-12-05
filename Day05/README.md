# Day 5

## Union and Difference

Today we're going to look combining shapes in different ways with `difference` and `union`.

Create a new file (say, `day05.scad`) and create a `cylinder` and a `cube` that overlap:

``` OpenSCAD
    cylinder(r = 20, h = 5);
    cube([20, 20, 5]);
```

This should make a teardrop shape when you save or preview.

Now, let's put these inside a `union()` block, like this:

``` OpenSCAD
union() {
    cylinder(r = 20, h = 5);
    cube([20, 20, 5]);
}
```

There's no difference, right? So why would you do this? Well, sometimes you want to group shapes together. We'll get to why later, but for now, let's use this to think about what we've told OpenSCAD to do; we've told it that the shape we want is the result of joining one shape to another shape.

Now, what happens if we change `union` to `difference`? Give it a try. Note, this may not display cleanly; if you don't see a difference (or you just see a cylinder) then try pressing F6 or clicking "design -> render" instead (this is because the computer has to do quite a lot of work to calculate exactly where edges sit; when you have faces close to each other, 'preview' sometimes gets it a bit wrong).

Just as we can use `union` to get the result of joining shapes together, we can use `difference` to get the result of taking one shape away from another.

An important thing to note here; `union` is "commutative" - this means it doesn't matter what order the objects are in when you join them together (just like it doesn't matter what order numbers are in when you add them)... But it does matter what order the objects are in when you're getting the `difference`.

See what happens when you put the `cube` first in that `difference` block (again, you might need to render instead of preview).

Anyway, the fact that `difference` is not commutative means that the order of the shapes matters - and this is one reason why `union` is useful; sometimes we need to be sure of what order we're doing something in.

## Adjusting scale

So far, we've been able to change the length of a `cylinder` and the radius of each circular face - but what if we want an ellipse (a squashed circle)?

OpenSCAD's `scale` feature can help us here. Try this:

``` OpenSCAD
                scale([0.6, 1, 1])
                    cylinder(r = 15, h = 5);
```

You should see a circle that's "squashed" in the X axis; `scale` takes a vector of dimensions for each axis. In this case, with `[0.6, 1, 1]`, we've specified an X scale of `0.6` and Y and Z scales of `1`. You can try changing those values and see what happens.

Now, let's combine `scale` and `difference`:

``` OpenSCAD
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
```

You should get an ellipse with a little bit taken off. Now, after the `difference` block, add a cuboid, like this:

`translate([-7, -10, 0]) cube([12, 8, 5]);`

Kinda looks like the sole of a shoe, right? Let's make it into a module called `sole` (I'll leave that to you; look at my code if you get stuck)...

And now let's make some footprints in the snow:

``` OpenSCAD
module footprints() {
    difference() {
        // me make some 'snow' by making a large, flat, white cuboid.
        color("white")
            translate([-100, 0, -6]) cube([200, 1200, 10]);

        // make 20 footprints in the snow: For each footprint
        for(step = [0 : 20]) {
            // decide if it's right or left (we pick one by seeing if 'step' is odd or even)
            mirror([step % 2 == 1 ? 1 : 0, 0, 0])
                // draw a footprint 10m off the (x) centre line,
                // increasing the distance (y) by 60mmm with each step
                translate([-10, 60 * step, 0]) sole();
        }
    }
}

footprints();
```

### Refinement

The shape we've used for the heel doesn't work too well. You could try something else; for example, `polygon` allows us to draw our own shapes in 2d, and `linear_extrude` (which we've used before) turns them into a 3d shape. Maybe try replacing the last `cube` in `sole` with this:

``` OpenSCAD
    // A shaped boot heel
    linear_extrude(5) polygon([[-6, -10], [-7, -2], [5, -2], [4, -10]]);
```

That's it for today. Tomorrow is going to be an exercise in putting some of these things together.

My sample code for today is [here](day05.scad).