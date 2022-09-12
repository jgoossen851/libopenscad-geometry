// ### Usage #########################################################
translate_and_mirror([-10, 20, 0]) {
  cube([10, 10, 10], center = true);
  cube(8);
}


// ### Module ########################################################
// dims - distance to translate object and repel mirrored object
module translate_and_mirror(dims) {
  // Object
  translate(dims)
  children();
  // Mirror
  translate(-1 * dims)
  mirror(dims)
  children();
}
