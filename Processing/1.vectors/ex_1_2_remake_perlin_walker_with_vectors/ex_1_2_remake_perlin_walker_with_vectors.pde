void vEllipse( PVector origin, float x_rad, float y_rad ) {
  ellipse( origin.x, origin.y, x_rad, y_rad );
}
  

class Walker {
  PVector origin;
  PVector step;
  float tx,ty;
  float radius;
 
  Walker() {
    origin = new PVector( width / 2, height / 2 ); 
    radius = 16;
    step = new PVector(0, 0);
    tx = 3;
    ty = 10000;
  }
 
  void display() {
    //ellipse(x,y,16,16);
    vEllipse(origin, radius, radius);
  }

  void step() {
    PVector clone = origin.copy();
    step.x = map(noise(tx), 0, 1, -10, 10);
    step.y = map(noise(ty), 0, 1, -10, 10);
 
    clone.add( step );
    if( clone.x < 0 || clone.x > width ) step.x = -step.x;
    if( clone.y < 0 || clone.y > height ) step.y = -step.y;   

    origin.add( step );

    tx += 0.04;
    ty += 0.04;
  }
}

Walker w;

void setup() {
  background(255);
  size( 640, 360 );
  w = new Walker();
}

void draw() {
  w.step();
  w.display();
}