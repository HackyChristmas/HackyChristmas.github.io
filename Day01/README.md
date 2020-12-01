# Day 1

Today's challenge consists of two parts:
 - Download and install OpenSCAD
 - Build a snowman

## Download and Install OpenSCAD

Head over to the OpenSCAD website, download the version of OpenSCAD for the type of computer you're using and install it (if the computer is not yours, you'll need permission - and possibly some help - to do this).

## Build a Snowman

Start OpenSCAD. You will see a window that's split vertically into two parts:
 - A left hand panel labelled 'Editor'
 - A right hand panel showing some scale lines (possibly with a 'Console' panel beneath it)

Click in the Editor window so it has the keyboard focus and copy the following code into it:
``` OpenSCAD
translate([0,0,50]) sphere(r = 50);
translate([0,0,120]) sphere(r = 25);
translate([0,0,135]) cylinder(r = 30, h =  2);
translate([0,0,135]) cylinder(r1 = 20, r2 = 25, h =  40);
```
