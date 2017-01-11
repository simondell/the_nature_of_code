PVector v;

void setup() {
  v = new PVector(34, 18);
  println("At first our vector has magnitude", v.mag());
  limit(v, 23);
  println("Then, after limit to 23, our vector has mag = ", v.mag());
}

void limit(PVector v, float max) {
  if( v.mag() > max ) {
    v.normalize();
    v.mult( max );
  }
}