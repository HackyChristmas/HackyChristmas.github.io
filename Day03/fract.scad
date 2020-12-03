module crystal(size = 20, angle = 30, depth = 2) {
    length = size + (2 * depth);
    width = pow(depth + 1, 0.5);
    translate([-width / 2, 0, -width / 2]) cube([width, length, width]);
    
    if (depth > 0) {
        translate([0, length, 0])
        for(a = [-angle : angle : angle]) {
            rotate([0, 0, a]) crystal(size = size - abs(a / 4), angle = angle * 0.7, depth = depth - 1);
        }
    }
}

module snowflake(depth = 5, angle = 40) {
    for(ang = [0 : 60 : 360])
        rotate([0,0,ang])
            crystal(depth = depth, angle = angle);   
}

module tree(angle = 40) {
    for(level = [0 : 4])
        translate([0, 0, 20 * level])
            rotate([0,0,(30 * level)])
                snowflake(depth = 5 - level, angle = angle);
}

snowflake(angle = 30, depth = 4);

//tree(angle = 30);