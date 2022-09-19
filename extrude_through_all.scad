use <cookie_cutter.scad>

// ### Usage #########################################################

$fa = $preview ? 10 : 1;    // minimum angle for a fragment
$fs = $preview ? 0.5 : 0.25;  // minimum size of a fragment

color("Green")
translate([0, 0, -10])
2d_profile_outline();

extrude_through_all_hull() {
  2d_profile_outline();

  translate([0, 0, 20])
  sphere(r = 6);
  translate([0, 0, 30])
  cube([4, 10, 10]);
}

module 2d_profile_outline() {
  difference() {
    2d_profile();
    offset(r = -1) 2d_profile();
  }
}

module 2d_profile() {
  square([10, 10], center = true);
  square([10, 6]);
}

// ### Module ########################################################

// Use the first child as a cookie-cutter (through-all intersection)
// on the remaining children
module extrude_through_all_hull(throughAll = 100) {
  eps = 0.01;

  cookie_cutter() {
    children(0);

    hull() {
      children([1:$children-1]);
    
      linear_extrude(eps, convexity = 10)
      projection()
      children([1:$children-1]);
    }
  }

  // Union original solid
  children([1:$children-1]);
}
