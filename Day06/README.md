# Day 6

Today we're going to put some things together.

First, find your programs from day 3 (probably called `snowman.scad`) and yesteday (probably `day05.scad`), and create a new file (say, `day06.scad`). You might find it useful for today's exercise to make sure all of your OpenSCAD files are in the same directory. I'll be assuming that's the case for the code examples.

In your new file, `day06.scad`, put the following code:

``` OpenSCAD
use <day05.scad>
sole();
```

`use` tells OpenSCAD to make use of the modules in another file. `day05.scad` defines the `sole` module, and so we can now use that in today's example. Note, it's only making the modules available, so anything you do outside of modules (like the `footprints();` line at the end) will be ignored. You can have these other things included too if you make use of `include` instead... but we don't want that for now.

We can also include the snowman from previous days. Let's use the day 3 snowman with the bugfix for the hat:

``` OpenSCAD
use <snowman.scad>
use <day05.scad>

translate([-60, 0, 0]) sole();
snowman(jauntiness = 15);
```

This is really useful because it means that once we make a shape, as long as we know where it is on the computer filesystem, we know we can use it without copying the code across to new files every time we want to use it. It makes keeping track of lots of different parts for a big project much easier.

## An exercise

So, we have access to our `snowman` and `sole` modules. Can you make a model of a cake with a `snowman` in the centre and footprints walking around the edge of the top?

Some hints:
 - A `cylinder` makes an excellent cake. Maybe a height of 100mm and a radius of 200mm makes something well proportioned for our snowman to sit on.
 - If the snowman is going to be sitting on the cake, it'll need to be moved 'up' to the top of the cake
 - Footprints going around the cake will be similar to footprints walking in a line - but you can use rotate instead of translate for each step... as long as you are rotating around the right point.

 If you get stuck, file an issue, ping me or call me.

 Or, just look at my version of the [today's code](day06.scad).