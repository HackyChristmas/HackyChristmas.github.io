# Day 12

Today we're going to look at some of what we can _do_ with these models. It's mostly show-and-tell, but I'm hoping to let you play a bit more with this tomorrow.

Let's take a really simple OpenSCAD program. Like this, perhaps:


``` OpenSCAD
cube([5, 5, 5]);
```

Pop that into an OpenSCAD file, then press F6 / Render, and then click the button to export this shape as an STL file.

What can you _do_ with this file? Well, you can use it for computer-aided-machining (CAM), or you can 3D print it or you can just, you know, _look_ at it.

I've made a web page that allows you to view this shape in 3D using your browser (assuming it supports WebGL). You can take a look [here](cube.html).