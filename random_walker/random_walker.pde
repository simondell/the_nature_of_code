import java.util.Random;

class Walker {
  int x;
  int y;
  Random generator;

  Walker( Random gen ) {
    x = width/2;
    y = height/2;
    generator = gen;
  }

  void display() {
    float red, green, blue;

    red = (float) generator.nextGaussian() * 125 + 60;
    green = (float) generator.nextGaussian() * 125 + 60;
    blue = (float) generator.nextGaussian() * 125 + 60;
    
    noStroke();
    fill((int)red, (int)green, (int)blue, 30);
    ellipse(x,y, 8, 8);
  }

  void step() {
    float stepSize = (float) generator.nextGaussian();
    int choice = int(random(4));
    int mean = 10;
    int sd = 5;

    float distance = sd * stepSize + mean;

    if (choice == 0) {
      x += distance;
    } else if (choice == 1) {
      x -= distance;
    } else if (choice == 2) {
      y += distance;
    } else {
      y -= distance;
    }
  }
}

Walker w;

void setup() {
  size( 640, 360 );
  w = new Walker( new Random() );
  background(255);
}

void draw() {
  w.step();
  w.display();
}