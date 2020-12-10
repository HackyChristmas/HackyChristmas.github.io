# Day 9

Yesterday (OK, on the 8th - I'll acknowledge being late with this one), we looked at using 2D shapes from another application. What if we've got a 3D file from another application and we want to open it in OpenSCAD?

Well, it turns out we can do that - and it uses the same feature.

For the next step I need you to download a file. Specifically, [this model of a duck](https://www.thingiverse.com/thing:139894) (go to 'download all files' on the page and it'll download a zip archive). Extract the zip file and copy the file (in 'files' in the archive) called `Rubber_Duck.stl` into the directory you'll be working in today.

Now create an OpenSCAD file (say, `day09.scad`) and enter the following code:


``` OpenSCAD
import("Rubber_Duck.stl");

```

F5 / Preview and you'll see a model of a duck. Cool, right?

Now download [this model](https://www.thingiverse.com/thing:597082) and extract `horse.STL` into the same directory.

Change the code above to read:

``` OpenSCAD
import("horse.STL");
```

... and this time we have a horse.

I only really want to cover one thing today; the idea of taking a 2D `projection` of a 3D shape. What's a `projection`? Well, imagine you're standing in front of a projector and you place your hand in the beam of light; you get a shadow (a 2D shape) from a cross-section of your hand (a 3D shape). It's a bit like that.

Let's give it a try:

``` OpenSCAD
difference() {
    cube([60, 130, 2], center = true);
    linear_extrude(height = 3, center = true) projection() import("horse.STL");
}

```

F5 / Preview (this might take a while)... and you've got a horse shaped hole. Fun, huh?

Try rotating the horse a bit (and trying different sized cuboids) to see if you can get a "horse thrown sideways through a door" effect.

You can download the code from today's exercise [here](day09.scad)