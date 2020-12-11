# Day 11

So, maybe you've been doing these exercises and thinking "Why OpenSCAD?" - there are many ways of making 3D models; graphical CAD tools, 3D sketching software, mesh editors, Blender; so why would you want to use this one?

There are two reasons why I use it:

Firstly, it's because OpenSCAD allows you to express shapes that would be really, really fiddly using software that's driven from the UI. You can do a lot with not too much work (as, hopefully, you'll have seen with the snowflake on [day 4](../Day04/)).

Secondly, if you have something that you want to express in a number of different forms, you can use the parameters in an OpenSCAD module to change shapes (even quite complex ones) really, really quickly.

Let's look at an example. We can make a (fairly) simple fan / propeller design with a program a bit like this:

``` OpenSCAD
module fan(blades = 3, hub_radius = 30, fan_radius = 100, pitch = 30) {
    intersection() {
        scale([1, 1, 2]) sphere(r = hub_radius);
        cylinder(r = hub_radius, h = hub_radius * 2);
    }
    translate([0, 0, hub_radius / 3]) for(blade_angle = [0 : 360 / blades : 360]) {
        rotate([0, 0, blade_angle]) rotate([0, 90 - pitch, 0]) cube([2, fan_radius, hub_radius]);
    }
}

fan();
```

As you can see, the module allows us to change the number of `blades`, the `pitch` (a propeller's pitch is the angle at which the blade cuts through the air) and the radius of both the hub (the middle bit of the fan) and the fan itself.

Let's say we want to try which value works best for some application; if you were using something like Sketchup, this would take hours (you'd need to make a model for each and every combination of blade number and pitch).  With OpenSCAD, we just do this:

``` OpenSCAD
// replace 'fan();' with this code:

fan_radius = 100;

translate([-1500, - 1000, 0])
for (blades = [2 : 10], pitch = [10 : 10 : 80]) {
    translate([2.5 * fan_radius * blades, 2.5 * fan_radius * pitch / 10, 0]) fan(blades = blades, pitch = pitch);
}
```

F5 / Preview and you'll see 72 fans... with varying blade counts and pitch angles. And very little work.

Today's code is [here](day11.scad).