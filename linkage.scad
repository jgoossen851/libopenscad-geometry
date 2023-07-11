
// ### Submodules ####################################################

use <layout.scad>

// ### Usage #########################################################

$fa = $preview ? 20 : 1;    // minimum angle for a fragment
$fs = $preview ? 1 : 0.25;  // minimum size of a fragment

points = [[-10, -10],
          [0, 0],
          [0, 10],
          [0, 20],
          [40, -20]];

linear_extrude(height = 1) 
linkage( points, r = 4, t = 12 );

// ### Module ########################################################

// Generic Linkage Profile
module linkage( points, r = 0, t = 10 ) {
  difference() {
    hull() { linkage_layout( points, r = t/2 ); }
    linkage_layout( points, r = r );
  }
}

module linkage_layout( points, r ) {
  for ( ipoint = points ) {
    translate([ ipoint[0], ipoint[1], 0 ])
    circle( r = r );
  }
}
