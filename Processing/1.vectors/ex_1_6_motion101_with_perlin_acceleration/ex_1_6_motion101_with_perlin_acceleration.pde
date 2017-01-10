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
  float topspeed, noise_rate, noise_index_x, noise_index_y, prev_noise_x, prev_noise_y;
 
  Mover() {
    location = new PVector(random(width),random(height));
    velocity = new PVector(random(-2,2),random(-2,2));
    acceleration = new PVector(0,0);
    topspeed = 10;
    noise_rate = 0.04;
    noise_index_x = 0;
    noise_index_y = 15000;
    prev_noise_x = noise(noise_index_x);
    prev_noise_y = noise(noise_index_y);
  }
 
  void update() {
    float new_noise_x = noise(noise_index_x);
    float new_noise_y = noise(noise_index_y);
    acceleration = new PVector(new_noise_x - prev_noise_x, new_noise_y - prev_noise_y);
    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    noise_index_x += noise_rate;
    noise_index_y += noise_rate;
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