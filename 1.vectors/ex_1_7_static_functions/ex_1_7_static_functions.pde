// The PVector v equals (1,5).
PVector v = new PVector(1,5);
println(v);

// The PVector u equals v multiplied by 2.
PVector u = PVector.mult(v,2);
println(u);

// The PVector w equals v minus u.
PVector w = PVector.sub(v, u);
println(w);

// Divide the PVector w by 3.
w.div(3);
println(w);