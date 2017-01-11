Mover mover;
 
void setup() {
  size(640,360);
  mover = new Mover();
}
 
void draw() {
  background(255);
 
  mover.update();
  mover.checkEdges();
  mover.display();
}
 
class Mover {
 
  PVector location;
  PVector velocity;
  PVector acceleration;
  float topspeed;
 
  Mover() {
    location = new PVector(random(width),random(height));
    velocity = new PVector(random(-2,2),random(-2,2));
    acceleration = new PVector(0,0);
    topspeed = 14;
  }
 
  void update() {
    PVector mouse = new PVector(mouseX,mouseY);
    PVector diff = PVector.sub(mouse,location);
    float mag = diff.mag();
    float inv_mag = 1 / diff.mag();

    acceleration = PVector.mult(diff.normalize(), inv_mag );
println(mag, inv_mag);
    velocity.add(acceleration);
    velocity.limit(topspeed);
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