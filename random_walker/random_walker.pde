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
    float r = random(1);
    int choice = int(random(4));

    if (mousePressed && r < 0.2) {
      x += mouseX < x? -1: 1;      
      y += mouseY < y? -1: 1;      
      return;  
    }
    
    if (choice == 0) {
      x++;
    } else if (choice == 1) {
      x--;
    } else if (choice == 2) {
      y++;
    } else {
      y--;
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