# Day 2 we are going to:
 - Make the snowman reusable
 - Add some character
 - Make a snow crowd

## Make the Snowman Reusable

Imagine we want to make a model with more than one snowman; we'd have to copy the lines for each part of the snowman over and over. And then we'd have to change the `translate` bits for each and every part. There'd be lots of code, lots of repetition. And it'd be easy to make mistakes while you do all of that copying and pasting.

Fortunately, we can make use of something called a `module` to make this easier.

Start OpenSCAD and go back to the file you made yesterday. If you forgot to save it, don't worry; you can go back to [yesterday's instructions](../Day01/README.md) if you need to... or just copy what I put below.

We're going to make two changes to the code:
 - Firstly, we're going to put the shapes for the snowman in a `snowman` module
 - Secondly, we'll change some of the code to allow us to use the module in a flexible way

### Making a snowman module

This part is fairly straightforward. You can make a module by just doing something like this (this is an example; the actual code you want is below...):
``` OpenSCAD
module my_new_module() {
  // the shapes for your module
}
```

In the case of our snowman, that might look like:

``` OpenSCAD
module snowman() {
  translate([0,0,50]) sphere(r = 50);
  translate([0,0,120]) sphere(r = 25);
  translate([0,0,135]) cylinder(r = 30, h =  2);
  translate([0,0,135]) cylinder(r1 = 20, r2 = 25, h =  40);
}
```

Try that, then press F5 (or the Preview button in the button bar)... and nothing happens! Why not? Well, we need to tell OpenSCAD that we actually want to use the snowman... so, create a new line at the end of file that says:

``` OpenSCAD
snowman();
```

Here, we're making a `snowman` just like we made `sphere` and `cylinder` shapes yesterday. And it turns out we can tell the program where to put the snowman too! Try adding another line to say:

```OpenSCAD
translate([60, 60, 30]) snowman();
```

Press F5 / Preview again, and see what happens. Two snowmen! And one of them is flying!

### Various snowmen

What if we want to have lots of snowmen that are slightly different? Let's say we want some with hats at a jaunty angle and some with hats that are straight.

Well, we could have multiple modules, say `snowman`, `snowman_with_jaunty_hat` and `snowman_with_very_jaunty_hat`, copy the code and modify each one. Or, we can modify our module to let us specify how we want the snowman to look. Let's do this now.

Change the line that says
``` OpenSCAD
module snowman() {
```

to say

``` OpenSCAD
module snowman(jauntiness = 0) {
```

this tells OpenSCAD that snowmen can have `jauntiness` and that it defaults to 0. Now let's use that value. Change the lines that read:

``` OpenSCAD
  translate([0,0,135]) cylinder(r = 30, h =  2);
  translate([0,0,135]) cylinder(r1 = 20, r2 = 25, h =  40);
```

and change them them to look like this:

``` OpenSCAD
translate([0,0,135]) rotate([0, jauntiness, 0]) {
    cylinder(r = 30, h =  2);
    cylinder(r1 = 20, r2 = 25, h =  40);
  }
```

Now, change one of your `snowman();` usages to set a value other than 0. E.g:

``` OpenSCAD
snowman(jauntiness = 10);
```

And press F5 / Preview again. Do you have a snowman with a jaunty hat? Yes? Excellent.

Before we move on, I'd like to point out something. Previously, we had one `translate` before each shape. Now, we have a `translate` and a `rotate` that apply to several. We've grouped the shapes together by putting a block around them (enclosing them in`{` and `}`). We could have done this differently, for example:

``` OpenSCAD
  translate([0,0,135]) {
    rotate([0, jauntiness, 0]) {
      cylinder(r = 30, h =  2);
      cylinder(r1 = 20, r2 = 25, h = 40);
    }
  }
```

The result of this code is exactly the same as the original... but this version makes it clearer that the `rotate` is 'inside' the `translate`. Since the `translate` and the `rotate` apply to the same grouping of shapes, I didn't think it necessary.

### Making a Crowd

Two snowmen is nice but more would be better...

Add the following to the end of your program:

``` OpenSCAD

for (angle = [0 : 36 : 360]) {
    how_jaunty = 11 - angle % 21;
    rotate([0, 0, angle])
       translate([0, 300, 0])
          snowman(jauntiness = how_jaunty);
}
```

Preview again - and you'll see a crowd (well, actually a circle) of snowmen. All with varying degrees of hat angle.

#### What's going on there, then?

We're making use of another OpenSCAD feature; loops.

`for (angle = [0 : 36 : 360]) {` // This is the loop header. We're telling the program to start 'angle' at 0, increase by 36 each time and stop at 360. Everything within the loop is repeated for each value of `angle`.

`how_jaunty = 11 - angle % 21;` // This is some way to determine the hat angle (it doesn't really matter how we're doing this - but, if you're interested, we're taking the remainder of `angle` divided by 21... and subtracting that from 11)

`rotate([0, 0, angle])` // Rotate the things until the `;` character by `angle` degrees (around the 'z' axis)

`translate([0, 300, 0])` // Move the things until the `;` character 300mm away from the origin (along the 'y' axis)

`snowman(jauntiness = how_jaunty);` // draw a snowman with a hat that's as jaunty as the `how_jaunty` that we calculated earlier.
