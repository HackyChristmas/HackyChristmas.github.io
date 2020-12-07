module locomotive(
    boiler_length = 180,
    boiler_radius = 35,
    cab_length = 100,
    chassis_height = 10,
    funnel_height = 20,
    funnel_radius = 10,
    wheel_radius = 30,
    wheel_width = 5,
    loading_gauge = 100,
    length = 300)
    {
    chassis_width = loading_gauge - wheel_width * 2;
    translate([- chassis_width / 2, 0, wheel_radius]) cube([chassis_width, length, 10]);
    for(is_mirrored = [0, 1]) {
        mirror([is_mirrored, 0, 0]) for(y = [100, 175, 250]) {
            translate([chassis_width / 2, y, wheel_radius]) rotate([0, 90, 0]) cylinder(r = wheel_radius, h = wheel_width);
        }
    }   
    translate([0, cab_length, wheel_radius + chassis_height + boiler_radius])
        rotate([270, 0, 0])
        cylinder(r = boiler_radius, h = boiler_length);
    translate([-(chassis_width - 10) / 2, 0, wheel_radius + chassis_height]) cube([chassis_width - 10, cab_length, 2 * boiler_radius + funnel_height]);
    translate([0, cab_length + boiler_length - 2 * funnel_radius, wheel_radius + chassis_height + boiler_radius * 2]) cylinder(r = funnel_radius, h = funnel_height);
    translate([0, cab_length + (boiler_length / 2), wheel_radius + chassis_height + boiler_radius * 2]) sphere(r = funnel_radius);
}

locomotive();