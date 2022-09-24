// ### Usage #########################################################

$fa = $preview ? 10 : 1;    // minimum angle for a fragment
$fs = $preview ? 0.5 : 0.25;  // minimum size of a fragment

translate([0, 0, 20])
2d_profile();

cookie_cutter() {
  2d_profile();
  sphere(r = 6);
  cube([4, 10, 10]);
}

module 2d_profile() {
  square([10, 10], center = true);
  square([10, 6]);
}

// ### Module ########################################################

// Use the first child as a cookie-cutter (through-all intersection)
// on the remaining children
module cookie_cutter(throughAll = 100) {
  intersection() {
    linear_extrude(throughAll, center = true, convexity = 10)
    children(0);

    if ( $children > 0 ) {
      children([1:$children-1]);
    }
  }
}
