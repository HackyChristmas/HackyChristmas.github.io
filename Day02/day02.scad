 module snowman(jauntiness = 0) {
  translate([0,0,50]) sphere(r = 50);
  translate([0,0,120]) sphere(r = 25);
     
  translate([0,0,135]) {
    rotate([0, jauntiness, 0]) {
      cylinder(r = 30, h =  2);
      cylinder(r1 = 20, r2 = 25, h = 40);
    }
  }
 }
 
 snowman(jauntiness = 5);