// ### Usage #########################################################

$fa = $preview ? 10 : 1;    // minimum angle for a fragment
$fs = $preview ? 0.5 : 0.25;  // minimum size of a fragment

fillet_2d(r = -3)
fillet_2d(r = 1)
random_shape();

translate([0, 0, -1])
random_shape();

module random_shape() {
  square([10, 10], center = true);
  square([10, 6]);
}

// ### Module ########################################################

// External fillet (internal if negative r)
module fillet_2d(r = 0) {  
  offset(r=+r)
  offset(delta=-r)
  children();
}
