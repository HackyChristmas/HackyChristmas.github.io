# Day 8

Remember how we looked at using 3D shapes from other files [the other day](../Day06/README.md)?

Today we'll look at using 2D shapes from other applications. Don't worry, you don't need to have or know how to use the other program to learn about this; I'll provide a file for you:

[Here](splodge.dxf) it is. It's a `dxf` file (that's a file format used by AutoCAD - and many other programs -for exchanging images). You can create DXF files from all sorts of things these days. I used [Inkscape](inkscape.org).

Anyway, we're going to use this file. Save it somewhere on your computer and create today's OpenSCAD file in the same location (I've called mine `day08.scad`).

Here's how we import our 2D file:

``` OpenSCAD
// import the DXF file "splodge.dxf" and extrude it to 0.5mm
linear_extrude(height = 0.5) import("splodge.dxf");
```

F5 / Preview and you'll see that we've created a sort of splodge shape.

We can do pretty much all of the things we can do with the built-in shapes with the things we `import`. For example, let's try an `intersection`. Replace the contents of your file with:

``` OpenSCAD
intersection() {
    // import the DXF file "splodge.dxf" and get its intersection with a sphere
    linear_extrude(height = 41) import("splodge.dxf");
    sphere(r = 40);
}
```

F5 / preview (or you might need to F6 / Render) and you'll get a sort of domed splodge. Yay!

OK, let's make this a bit more interesting by making the corners a bit softer. We'll do this by using something called a `minkowski` transform. What this does is combines two 3D shapes in a particular way. You know when you hold a pen with a shaped nib (like a calligraphy pen or somerthing) and you draw, you get the 2d shape of the nib sort of drawn along the path you've drawn? Well imagine you have a 3D shape as a sort of brush for drawing in the air and you 'colouring in` another shape with it.

I've probably explained that terribly so let's see it. Replace the contents of your file with:

``` OpenSCAD
minkowski() {
    cube([10, 10, 10]);
    sphere(r=5);
}
```

F5 / Render. You'll have a sort of curved cube. It's 20mm in each dimension because we started with a 10mm `cube` and a 5mm radius `sphere`.

We're going to use that in today's model:

``` OpenSCAD
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
```

Ok, now try adding a couple of cherries on the top...

We can do some more with this another day.