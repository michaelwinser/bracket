// bracket
//   target_object = [width, depth, height]
//   margin

bracket(width = 143.5, depth = 94.5, height = 45.6, thickness = 3);

module bracket(width, depth, height, thickness) {
    bracket_width = width + thickness * 2;
    bracket_depth = 25;
    flange_width = 30;
    flange_height = thickness;
    bracket_height = height + thickness;

    rotate([90, 0, 0]) {
        difference() {
            translate([-thickness, 0, 0]) { 
                cube([bracket_width, bracket_depth, bracket_height]);
            }
            cube([width, depth, height]);
        }
        translate([-flange_width, 0, 0]) {
            flange(flange_width, bracket_depth, flange_height, hole_radius = 3);
        }
        
        translate([bracket_width - thickness, 0, 0]) {
            flange(flange_width, bracket_depth, flange_height, hole_radius = 3);
        }
        
    }
    
    translate([0, -height, 0]) {
        triangle(height, flange_width, thickness);
    }
    rotate([0, 0, 90]) {
        triangle(flange_width, -height, thickness);
    }
    
    translate([width, 0, 0]) rotate([0, 0, -90]) {
        triangle(flange_width, height, thickness);
    }
    
    translate([width, -height, 0]) {
        triangle(height, -flange_width, thickness);
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

/**
 * Standard right-angled triangle
 *
 * @param number  o_len  Length of the opposite side
 * @param number  a_len  Length of the adjacent side
 * @param number  depth  How wide/deep the triangle is in the 3rd dimension
 * @param boolean center Whether to center the triangle on the origin
 * @todo a better way ?
 */
module triangle(o_len, a_len, depth, center=false)
{
    centroid = center ? [-a_len/3, -o_len/3, -depth/2] : [0, 0, 0];
    translate(centroid) linear_extrude(height=depth)
    {
        polygon(points=[[0,0],[a_len,0],[0,o_len]], paths=[[0,1,2]]);
    }
}
