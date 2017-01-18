class Balloon {
  PVector location, velocity, acceleration;
  float radius;
  float balloon_height;
  
  Balloon (float x, float y, float r) {
    radius = r;
    balloon_height = r * 1.618;
    location = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  void applyForce (PVector f) {
    acceleration.add( f );
  }
  
  void update () {

    if( location.y <= balloon_height ) {
      PVector rebound = PVector.mult( PVector.add( velocity, acceleration ), -1.23 );
      applyForce( rebound );
    }
    
    velocity.add(acceleration);
    velocity.limit( 15 );
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display () {
    fill(255, 175, 32);
    stroke(205, 125, 6);
    ellipse( location.x, location.y, radius, balloon_height );
  }
}

Balloon balloon;
PVector buoyancy;
PVector gravity;

void setup () {
  size( 396, 640 );
  balloon = new Balloon( width / 2, height, 23 );
  buoyancy = new PVector( 0, -9.85 );
  gravity = new PVector( 0, 9.8 );
}

void draw () {
  background(255);
  balloon.applyForce( gravity );
  balloon.applyForce( buoyancy );
  balloon.update();
  balloon.display();
}