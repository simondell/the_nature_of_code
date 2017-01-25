class Balloon {
  PVector location, velocity, acceleration;
  float radius;
  color skin;
  float mass;

  Balloon (float x, float y, float m, color c) {
    skin = c;
    mass = m;
    radius = m * 10;
    location = new PVector(x, y);
    velocity = new PVector();
    acceleration = new PVector();
  }

  void applyForce (PVector f) {
    PVector accel = PVector.div( f, mass );
    acceleration.add( accel );
  }

  void update () {
    velocity.add(acceleration);
    velocity.limit( 15 );
    location.add(velocity);
    acceleration.mult(0);
  }

  void display () {
    fill(skin);
    stroke(255);
    ellipse( location.x, location.y, radius, radius );
  }
}




Balloon[] balloons;
PVector gravity = new PVector(0, 0.5);

//
// event handlers
//
void setup () {
  size( 640, 396 );

  balloons = new Balloon[1];

  int len = balloons.length;
  for( int i = 0; i < len; i++ ) {
	  balloons[i] = balloonFactory( random(width), random(height), 10 );
  }
}

void draw () {
  background(255);

  int len = balloons.length;
  for( int i = 0; i < len; i++ ) {
  	balloons[i].applyForce( gravity );
    balloons[i].update();
    balloons[i].display();
  }
}

void mousePressed() {
  Balloon new_oone = balloonFactory( mouseX, mouseY, random(10) );
  balloons = (Balloon[]) append(balloons, new_oone);
}

//
// helpers
//
color getRandomColor() {
  return color(random(255), random(255), random(255), random(255));
}

Balloon balloonFactory (float x, float y, float m) {
  PVector shove;
  Balloon b = new Balloon( x, y, m, getRandomColor() );

  shove = PVector.random2D();
  shove.mult(random(20));
  b.applyForce( shove );
  return b;
}
