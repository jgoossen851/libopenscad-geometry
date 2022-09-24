
// ### Usage #########################################################

color("Red", 0.5)
abs_square([[4, 10], [8, -3]]);

color("Orange", 0.5)
abs_cube([[-1, 3.5], [-3, 8], [1, -1]]);

// ### Module ########################################################

module abs_square(dims_2d) {
  translate([min(dims_2d.x), min(dims_2d.y)])
  square([abs(dims_2d.x[1] - dims_2d.x[0]),
          abs(dims_2d.y[1] - dims_2d.y[0])]);
}

module abs_cube(dims_3d) {
  translate([min(dims_3d.x), min(dims_3d.y), min(dims_3d.z)])
  cube([abs(dims_3d.x[1] - dims_3d.x[0]),
        abs(dims_3d.y[1] - dims_3d.y[0]),
        abs(dims_3d.z[1] - dims_3d.z[0])]);
}
