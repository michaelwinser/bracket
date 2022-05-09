// bracket
//   target_object = [width, depth, height]
//   margin

bracket(width = 143.5, depth = 94.5, height = 45.6, thickness = 3);

module bracket(width, depth, height, thickness) {
    bracket_width = width + thickness * 2;
    bracket_depth = 25;
    flange_width = 30;
    bracket_height = height + thickness;

    rotate([90, 0, 0]) {
        difference() {
            translate([-thickness, 0, 0]) { 
                cube([bracket_width, bracket_depth, bracket_height]);
            }
            cube([width, depth, height]);
        }
        translate([-flange_width, 0, 0]) {
            flange(flange_width, bracket_depth, thickness, 3, 1);
        }
        
        translate([bracket_width - thickness, 0, 0]) {
            flange(flange_width, bracket_depth, thickness, 3, 1);
        }
    }
}


module flange(width, depth, thickness, hole_radius = 3, hole_count = 1) {
    difference() {
        cube([width, depth, thickness]);
        // evenly distribute hole_count holes across width
        // hole_count holes ==> hole_count + 1 spaces between holes
        
        hole_spacing = width / hole_count;
        
        // offset by half a space to start
        offset = hole_spacing / 2;
        
        for (i = [0:hole_count]) {
            hole_offset = offset + i * hole_spacing;
            
            translate([hole_offset, depth / 2, 0]) {
                cylinder(thickness, hole_radius, hole_radius);
            }
        }
    }
}