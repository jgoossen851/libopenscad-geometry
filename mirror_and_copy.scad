// ### Usage #########################################################
mirror_and_copy([-10, 20, 0]) {
  translate([20, 0, 0]) {
    cube([10, 10, 10], center = true);
    cube(8);
  }
}


// ### Module ########################################################
// dims - normal vector to mirror plane
module mirror_and_copy(dims) {
  // Object
  children();
  // Mirror
  mirror(dims)
  children();
}
