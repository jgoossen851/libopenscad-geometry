// ### Usage #########################################################

// Traditional Method
translate([-10, 0, 0]) 
difference() {
  union() {
    difference() {
      union() {
        cube(12, center=true);
      }
      sphere(8);
    }
    translate([0, 0, 6])
    cylinder (h = 4, r=1, center = true, $fn=100);

    translate([0, 0, -6])
    cylinder (h = 4, r=1, center = true, $fn=100);
  }
  translate([0, 0, 6])
  rotate ([90,0,0])
  cylinder (h = 20, r=0.9, center = true, $fn=100);

  translate([0, 0, -6])
  rotate ([90,0,0])
  cylinder (h = 20, r=0.9, center = true, $fn=100);
}

// Using sculpt()
translate([10, 0, 0]) 
sculpt(levels = 2) {
  append(1) 
  cube(12, center=true);

  remove(1)
  sphere(8);

  append(2) {
    translate([0, 0, 6])
    cylinder (h = 4, r=1, center = true, $fn=100);

    translate([0, 0, -6])
    cylinder (h = 4, r=1, center = true, $fn=100);
  }

  remove(2)
  translate([0, 0, 6])
  rotate ([90,0,0])
  cylinder (h = 20, r=0.9, center = true, $fn=100);

  remove(2)
  translate([0, 0, -6])
  rotate ([90,0,0])
  cylinder (h = 20, r=0.9, center = true, $fn=100);
}


// ### Module ########################################################


// Sculpt an object by appending and removing material in levels
// At each level, add the union of all `append` objects and then
// subtract the union of all `remove` objects.
module sculpt(levels = 1) {
  difference() {
    union() {
      if ( levels > 1 ) {
        // First process lower levels
        sculpt(levels-1)
        children();
      }
      // Union "appends" from this level
      activate_append(levels)
      children();
    }
    // Subtract "removes" from this level
    activate_remove(levels)
    children();
  }
}

module activate_append(level) {
  $level = level;
  children();
}

module activate_remove(level) {
  $level = level;
  children();
}

module append(level = 1) {
  msg = "The append module must be called as a child of the `sculpt` module";
  assert( $parent_modules >= 2, msg);
  assert( parent_module(1) == "activate_append" ||
          parent_module(1) == "activate_remove" , msg);

  if ( parent_module(1) == "activate_append" &&
       $level == level ) {
    children();
  }
}

module remove(level = 1) {
  msg = "The remove module must be called as a child of the `sculpt` module";
  assert( $parent_modules >= 2, msg);
  assert( parent_module(1) == "activate_append" ||
          parent_module(1) == "activate_remove" , msg);

  if ( parent_module(1) == "activate_remove" &&
       $level == level ) {
    children();
  }
}
