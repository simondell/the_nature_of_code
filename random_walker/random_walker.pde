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
    int choice = int(random(4));
    
    switch(choice) {
      case 0: x++; break;
      case 1: x--; break;
      case 2: y++; break;
      case 3: x--; break;
    }
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