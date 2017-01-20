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

    if( location.y <= balloon_height / 2 ) {
      PVector rebound = new PVector( 0, velocity.y + acceleration.y );
      rebound.y *= -1.23;
      applyForce( rebound );
    }
    
    velocity.add(acceleration);
    velocity.limit( 15 );
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display () {
    fill(255, 175, 32, 0.5);
    stroke(255, 175, 32, 0.5);
    ellipse( location.x, location.y, radius, balloon_height );
  }
}

Balloon[] balloons;
PVector buoyancy;
PVector gravity;
PVector wind;
float t;

void setup () {
  size( 396, 640 );
  balloons = new Balloon[1];
  balloons[0] = new Balloon( 0, height, 23 );
  buoyancy = new PVector( 0, -9.84 );
  gravity = new PVector( 0, 9.8 );
  wind = new PVector( 0.01, 0 );
  t = 10000;
}

void mouseClicked() {
  //Balloon new_one = new Balloon( mouse.x, mouse.y, 23 );
  //balloons = append(balloons, new_one);
}

void draw () {
  //wind.x = noise( t ) * 0.01 + 1;
  background(255);
  int len = balloons.length;
  for( int i = 0; i < len; i++ ) {
    balloons[i].applyForce( gravity );
    balloons[i].applyForce( buoyancy );
    balloons[i].applyForce( wind );
    balloons[i].update();
    balloons[i].display();
  }
  t += 0.01;
}