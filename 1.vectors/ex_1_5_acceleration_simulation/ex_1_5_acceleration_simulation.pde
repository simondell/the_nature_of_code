Mover mover;
PVector force;

void setup() {
  size(640,360);
  force = new PVector(0,0);
  mover = new Mover(10, height - 10);
}

void draw() {
  background(255);
 
  if( !keyPressed ) {
    force.set(0,0);
  }
 
  mover.update();
  mover.checkEdges();
  mover.display();
}


class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
  
  Mover(Integer startx, Integer starty) {
    location = new PVector(startx, starty);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    topspeed = 10;
  }
 
  void update() {
    if( keyPressed ) {     
      if (key == CODED) {
        if (keyCode == UP) {
          acceleration.x = 0.03;
        } else if (keyCode == DOWN) {
          acceleration.x = -0.06;
        }
      }
    } else {
      acceleration.x = 0;
    }
    
    velocity.add(acceleration);
    velocity.limit(topspeed);
    if(velocity.x <= 0.0) { velocity.setMag(0); }
    location.add(velocity);
  }
 
  void display() {
    stroke(0);
    fill(175);
    ellipse(location.x,location.y,16,16);
  }
 
  void checkEdges() {
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
 
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}