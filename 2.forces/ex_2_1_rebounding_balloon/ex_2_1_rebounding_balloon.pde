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
println(acceleration);
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
PVector wind;
float t;

void setup () {
  size( 396, 640 );
  balloon = new Balloon( 0, height, 23 );
  buoyancy = new PVector( 0, -9.84 );
  gravity = new PVector( 0, 9.8 );
  wind = new PVector( 1, 0 );
  t = 10000;
}

void draw () {
  //wind.x = noise( t ) * 0.01 + 1;
  background(255);
  balloon.applyForce( gravity );
  balloon.applyForce( buoyancy );
  balloon.applyForce( wind );
  balloon.update();
  balloon.display();
  t += 0.01;
}