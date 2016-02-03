class Walker {
  float x,y, step_x, step_y;
 
  float tx,ty;
 
  Walker() {
    x = width / 2;
    y = height / 2;
    tx = 0;
    ty = 10000;
  }
 
  void display() {
    ellipse(x,y,16,16);
  }

  void step() {
    step_x = map(noise(tx), 0, 1, -10, 10);
    step_y = map(noise(ty), 0, 1, -10, 10);
 
    x += step_x;
    y += step_y;
    tx += 0.01;
    ty += 0.01;
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