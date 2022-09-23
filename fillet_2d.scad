// ### Usage #########################################################

$fa = $preview ? 10 : 1;    // minimum angle for a fragment
$fs = $preview ? 0.5 : 0.25;  // minimum size of a fragment

color( "SeaGreen" )
fillet_2d(r = -3)
fillet_2d(r = 1)
random_shape();

color( "Coral" )
translate([0, 0, 1])
fillet_2d(r = [-3, 1])
random_shape();

color( "Olive" )
translate([0, 0, -1])
random_shape();

module random_shape() {
  square([10, 10], center = true);
  square([10, 6]);
}

// ### Module ########################################################

// External fillet (internal if negative r)
module fillet_2d(r = 0) {
  if (is_list(r) && len(r) == 2) {
    fillet_2d(r[0])
    fillet_2d(r[1])
    children();
  } else {
    offset(r=+r)
    offset(delta=-r)
    children();
  }
}
