class Walker {
  int x;
  int y;
  
  Walker() {
    x = width/2;
    y = height/2;
  }

  void display() {
    stroke(0);
    point(x,y);
  }

  void step() {
    int stepx = int(random(3))-1;
    int stepy = int(random(3))-1;
    x += stepx;
    y += stepy;
  }
}

Walker w;

void setup() {
  w = new Walker();
  background(255);
}

void draw() {
  w.step();
  w.display();
}