// ### Usage #########################################################
intersection() {
  shell() cube([10, 10, 10]);
  cube([10, 10, 5]);
}


// ### Module ########################################################

module shell(t = 1) {
  intersection() {
    children();
    // Minkowski Sum: Solid Convolution
    render(convexity = 2) { 
      minkowski() {
        // Negative image of children
        difference() {
          // Universe shape: Larger than children
          minkowski() {
            children();
            cube(1, center = true); // Minkowski tool
          }
          children();
        }
        sphere(r = t); // Minkowski tool
      } 
    }
  }
}
