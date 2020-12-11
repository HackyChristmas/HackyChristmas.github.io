module fan(blades = 3, hub_radius = 30, fan_radius = 100, pitch = 30) {
    intersection() {
        scale([1, 1, 2]) sphere(r = hub_radius);
        cylinder(r = hub_radius, h = hub_radius * 2);
    }
    translate([0, 0, hub_radius / 3]) for(blade_angle = [0 : 360 / blades : 360]) {
        rotate([0, 0, blade_angle]) rotate([0, 90 - pitch, 0]) cube([2, fan_radius, hub_radius]);
    }
}

fan_radius = 100;

translate([-1500, - 1000, 0])
for (blades = [2 : 10], pitch = [10 : 10 : 80]) {
    translate([2.5 * fan_radius * blades, 2.5 * fan_radius * pitch / 10, 0]) fan(blades = blades, pitch = pitch);
}