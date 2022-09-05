// ### Usage #########################################################
prism([1, 2, 3]);
prism([2, 4, 1], invert = true);

translate([10, 0, 0])
prism_tapered_cuboid([4, 6, 2], 0.3);


// ### Module ########################################################

// A cube with center centered on the base
// dims - cube dimensions: [x, y, z]
// invert - center is on top
module prism(dims, invert = false) {
	if (invert) {
		rotate([180, 0, 0])
		prism_base(dims);
	} else {
		prism_base(dims);
	}
}

module prism_base(dims) {
	translate([0, 0, dims[2] / 2])
	cube(dims, center = true);
}


// A cuboid with a tapered top
// dims - cube dimensions: [x, y, z]
// taper - by how much to taper the each edge at the top
module prism_tapered_cuboid(dims, taper) {
  ho = taper;
  hx = dims.x - taper;
  hy = dims.y - taper;
  translate([-dims.x/2, -dims.y/2, 0])
  polyhedron( 
    points=[
      [     0,      0,      0],
      [ taper,  taper, dims.z],
      [    hx,  taper, dims.z],
      [dims.x,      0,      0],
      [     0, dims.y,      0],
      [ taper,     hy, dims.z],
      [    hx,     hy, dims.z],
      [dims.x, dims.y,      0] 
    ],
    faces = [
      //side face
      [0, 1, 2, 3],
      //side face
      [3, 2, 6, 7],
      //side face
      [7, 6, 5, 4],
      //side face
      [4, 5, 1, 0],
      //top face
      [1, 5, 6, 2],
      //bottom face
      [4, 0, 3, 7],
    ]
  );
}
