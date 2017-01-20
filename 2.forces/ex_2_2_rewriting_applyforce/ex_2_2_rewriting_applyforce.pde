class Balloon {
  PVector location, velocity, acceleration;
  float balloon_height;
  color skin;
  float mass;
  
  Balloon (float x, float y, float m, color c) {
    skin = c;
    mass = m;
    balloon_height = m * 16.18;
    location = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
  }
  
  void applyForce (PVector f) {
    PVector accel = PVector.div( f, mass );
    acceleration.add( accel );
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
    fill(skin);
    stroke(255);
    ellipse( location.x, location.y, mass * 10, balloon_height );
  }
}




Balloon[] balloons;
PVector buoyancy;
PVector gravity;
PVector wind;
float t;

color getRandomColor() {
  return color(random(255), random(255), random(255), random(255));
}

Balloon balloonFactory (float x, float y, float m) {
  return new Balloon( x, y, m, getRandomColor() );
}

void setup () {
  size( 640, 396 );
  balloons = new Balloon[1];
  balloons[0] = balloonFactory( 0, height, 3 );
  buoyancy = new PVector( 0, -9.84 );
  gravity = new PVector( 0, 9.8 );
  wind = new PVector( 32, 0 );
  t = 10000;
}

void mousePressed() {
  Balloon new_oone = balloonFactory( mouseX, mouseY, random(10) );
  balloons = (Balloon[]) append(balloons, new_oone);
}

void draw () {
  wind.x = noise( t ) * 0.007;
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