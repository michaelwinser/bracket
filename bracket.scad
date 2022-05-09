
// bracket(50, 100, 5, 0, 0, 0);

cube(50, 200, 50);

module bracket(width, depth, height, flange_width, top_thickness, flange_thickness) {
    cube(width, depth, height);
}

module test() {
    difference() {
        cube([50, 15  , 50]);
        translate([5, 0, 5]) {
            cube([40, 15, 40]);
        }
    }
}