
// ### Usage #########################################################
orient1 = 
  [
    [[1, 2], [-10]],
    [[1, 2, 0], [30, 0, 60]]
  ];
orient2 =
  [
    [[1, -3], 0],
    [[4, -3, 0], [0, 10, 30]]
  ];
composite = composite(orient2, orient1);
echo(composite);

color("Blue")
layout(orient1)
cube([1, 2, 3], center = true);

color("Red")
layout(orient2)
cube([1, 2, 3], center = true);

layout(composite(orient2, orient1))
cube([1, 2, 3], center = true);

// Pad vectors
echo(pad_to_n_vector(0, n = 3));
echo(pad_to_n_vector(1, n = 3));
echo(pad_to_n_vector([2], n = 3));
echo(pad_to_n_vector([3, 4], n = 3));
echo(pad_to_n_vector([5, 6, 7, 8], n = 3));
echo(pad_to_n_vector([9], n = 3, pad_left = true));


// ### Module ########################################################

// Using the 6DOF coordinate data in `data`, replicate the children modules
// Data formated as:
//    [
//      [[x, y, z], [phi, theta, psi]],
//      [[x, y, z], [phi, theta, psi]],
//      [[x, y], [psi]],
//      [[x, y], [psi]],
//      [[x, y], psi],
//      [[x, y], psi],
//      ...
//    ]
module layout(data) {
  for ( icoord = data ) {
    echo(icoord)
    if ( is_num(icoord[0]) ) {
      // (3D) 3-Vector Translation & No Rotation
      // [x, y, z]
      translate([icoord.x, icoord.y, icoord.z])
      children();
    } else if ( len(icoord[0]) == 3 && len(icoord[1]) == 3 ) {
      // (3D) 3-Vector Translation & 3-Vector Rotation
      // [[x, y, z], [phi, psi, theta]]
      translate([icoord[0].x, icoord[0].y, icoord[0].z])
      rotate([icoord[1].x, icoord[1].y, icoord[1].z])
      children();
    } else if ( len(icoord[0]) == 2 && is_num(icoord[1])) {
      // (2D) 2-Vector Translation & Scalar Rotation
      // [[x, y], phi]
      translate([icoord[0].x, icoord[0].y])
      rotate(icoord[1])
      children();
    } else if ( len(icoord[0]) == 2 && len(icoord[1]) == 1) {
      // (2D) 2-Vector Translation & 1-Vector Rotation
      // [[x, y], [phi]]
      translate([icoord[0].x, icoord[0].y])
      rotate(icoord[1][0])
      children();
    } else {
      assert(false, "Input coordinates not supported in layout() module");
    }
  }
}


// Apply the orientation of the first argument to the orientation of the second
// I.e., the orientation of an object placed at orient1 and the result subsequently
// placed via orient2 may be given as
//    composite(orient2, orient1)
// The resulting vector will have a length as long as the product of the two argument lengths
function composite(o2, o1) =
  [
    for ( i1 = [ 0 : len(o1) - 1 ], i2 = [ 0 : len(o2) - 1 ] )
    // Input Sanitation - Get 3-vectors
    let( r1 = pad_to_n_vector( o1[i1][0], n = 3 ) )
    let( a1 = pad_to_n_vector( o1[i1][1], n = 3, pad_left = true ) )
    let( r2 = pad_to_n_vector( o2[i2][0], n = 3 ) )
    let( a2 = pad_to_n_vector( o2[i2][1], n = 3, pad_left = true ) )

    let( Orient = rotation_matrix(a2) )
    [
      r1 * Orient + r2,
      euler_angles(rotation_matrix(a1) * Orient)
    ]
  ];


// Groves (2.22)
function rotation_matrix(euler) =
  let( sPhi = sin(euler.x) )
  let( cPhi = cos(euler.x) )
  let( sThe = sin(euler.y) )
  let( cThe = cos(euler.y) )
  let( sPsi = sin(euler.z) )
  let( cPsi = cos(euler.z) )
  [
    [                  cThe*cPsi,                   cThe*sPsi,     -sThe],
    [-cPhi*sPsi + sPhi*sThe*cPsi,  cPhi*cPsi + sPhi*sThe*sPsi, sPhi*cThe],
    [ sPhi*sPsi + cPhi*sThe*cPsi, -sPhi*cPsi + cPhi*sThe*sPsi, cPhi*cThe]
  ];


// Groves (2.23)
function euler_angles(rotation_matrix) =
  [
    atan2(rotation_matrix[1][2], rotation_matrix[2][2]), // phi,   roll
    -asin(rotation_matrix[0][2]),                        // theta, pitch
    atan2(rotation_matrix[0][1], rotation_matrix[0][0])  // psi,   yaw
  ];


// Add elements to a number or vector to create a vector of the desired length
function pad_to_n_vector(v, n = 3, pad_left = false) = 
  let( vector = is_list(v) ? v : [v] )
  let( n_vector = 
    len(vector) >= n 
      ? vector
      : pad_left
        ? concat([0], pad_to_n_vector(vector, n = n-1, pad_left = pad_left))
        : concat(pad_to_n_vector(vector, n = n-1, pad_left = pad_left), [0])
  )
  n_vector;
