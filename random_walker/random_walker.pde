import java.util.Random;

class Walker {
  int prev_x;
  int prev_y;
  Random generator;

  Walker( Random gen ) {
    prev_x = width/2;
    prev_y = height/2;
    generator = gen;
  }

  void walk() {
    float stepSize = (float) generator.nextGaussian();
    int choice = int(random(4));
    int mean = 10;
    int sd = 3;
    float new_x;
    float new_y;
    float distance = sd * stepSize + mean;

    if (choice == 0) {
      new_x = prev_x + distance;
      new_y = (float) prev_y;
    } else if (choice == 1) {
      new_x = prev_x - distance;
      new_y = (float) prev_y;
    } else if (choice == 2) {
      new_y = prev_y + distance;
      new_x = (float) prev_x;
    } else {
      new_y = prev_y - distance;
      new_x = (float) prev_x;
    }

    stroke(0);
    line(prev_x, prev_y, new_x, new_y );

    prev_x = (int) new_x;
    prev_y = (int) new_y;
  }
}

Walker w;

void setup() {
  size( 640, 360 );
  w = new Walker( new Random() );
  background(255);
}

void draw() {
  w.walk();
}