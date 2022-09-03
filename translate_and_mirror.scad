// ### Usage #########################################################
translate_and_mirror([-10, 20, 0], m = [-1, -1, 1]) {
  cube([10, 10, 10], center = true);
  cube(8);
}


// ### Module ########################################################
// dims - distance to translate object and repel mirrored object
// m - scaling factor for mirror to invert dimensions
module translate_and_mirror(dims, m = [1, 1, 1]) {
  // Object
  translate(dims)
  children();
  // Mirror
  translate(-1 * dims)
  scale(m)
  children();
  
}
