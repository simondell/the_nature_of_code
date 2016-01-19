class Walker {
  int x;
  int y;

  int[] directions;
  
  Walker() {
    x = width/2;
    y = height/2;
 
    directions = new int[10];
    directions[0] = -1;
    directions[1] = -1;
    directions[2] = -1;
    directions[3] = -1;
    directions[4] =  1;
    directions[5] =  1;
    directions[6] =  1;
    directions[7] =  1;
    directions[8] =  1;
    directions[9] =  1;
  }

  void display() {
    stroke(0);
    point(x,y);
  }

  void step() {
    int stepx = directions[ int(random(10)) ];
    int stepy = directions[ int(random(10)) ];
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