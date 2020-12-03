# Day 3
I got some feedback that I covered too much yesterday.  Let's take it easy today - and remember to ask me if you get stuck. You can file a [github issue](https://github.com/HackyChristmas/HackyChristmas.github.io/issues) if you don't know me (and just call me if you do!).


Today we're going to go over translation, rotation and grouping shapes again. We'll do this by:
 - Giving our snowman a nose, and
 - Fixing a bug

## Making a nose

First, we need to pick our nose. Snowmen can have all sorts of noses. I usually use a carrot so I'll go with that here.

We can approximate a carrot by making a cone. In OpenSCAD, a cone is created by making a `cylinder` that has a radius greater than zero at the bottom and a radius of zero at the top. Like this:

``` OpenSCAD
// a cone
cylinder(r1 = 5, r2 = 0, h = 20);
```

Now we need to put it in place. We know that the centre of the snowman's head is at 120mm above the origin and that the head is 25mm in diameter. First, let's just put our 'carrot' at that position and see what happens. Place this inside your `snowman` module before the final `{`:

```OpenSCAD
// A carrot
translate([0, -25, 120]) cylinder(r1 = 5, r2 = 0, h = 20);
```

Press F5 / Preview and see what happens. Your snowman should have a nose... but it'll be sticking up in the air. Before we fix that, let's think about what we've done so far:

`translate([0, -25, 120])` // the next thing needs to be 120mm away from the origin in the Z axis ('above', if you like) and 25mm away from the origin in the Y axis. The `-` sign tells OpenSCAD to put it 'before' the head and not after it.

`cylinder(r1 = 5, r2 = 0, h = 20);` // draw our carrot

OK. We can fix the sticking up nose with a `rotate`. Change the above code to:

```OpenSCAD
// A carrot
translate([0, -25, 120]) rotate([90, 0, 0]) cylinder(r1 = 5, r2 = 0, h = 20);
```

This changes the cone from being vertical by rotating it by 90 degrees (around the X axis).

F5 / Preview and you'll see the nose now sticks out. Maybe try playing with that angle a bit. See what happens.

## Fixing a Bug
Josh noticed that when you make the hat too jaunty it interferes with the head.

You can see this by making a snowman with a jauntiness of, say, 30 degrees:

`snowman(jauntiness = 30);`


Looks wrong, doesn't it?

We can fix this by making the hat rotate relative to the centre of the head, rather than the base of the hat. This is a valuable concept because being able to rotate and translate shapes relative to each other (rather than the origin) is useful in all sorts of ways.

Last time we touched the `hat` code, it looked like this:

```OpenSCAD
    // the snowman's hat
    translate([0, 0, 135]) rotate([0, jauntiness, 0]) {
        cylinder(r = 30, h =  2);
        cylinder(r1 = 20, r2 = 25, h =  40);
    }
```

First of all, we need to change the start `translate` so that it's in the middle of the snowman's head rather than the top so change the `135` to `120`.

If you preview now, you'll see the hat is in the wrong place (on account of it being in the middle of the head), so now we need to add another `translate` to move it back up another 15mm... but this time, inside the `rotate`. So now, the hat section will look like this:

```OpenSCAD
    // the snowman's hat
    translate([0, 0, 120]) rotate([0, jauntiness, 0]) {
        translate([0, 0, 15]) {
          cylinder(r = 30, h =  2);
          cylinder(r1 = 20, r2 = 25, h =  40);
        }
    }
```

We can test this by making a very crooked hat, like so: `snowman(jauntiness = 30);`

I've put this week's code [here](snowman.scad) so you can compare (or steal it if necessary!).
