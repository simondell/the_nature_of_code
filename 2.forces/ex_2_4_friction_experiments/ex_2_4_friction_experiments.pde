class Balloon {
  PVector location, velocity, acceleration;
  float diameter;
  color skin;
  float mass;

  Balloon (float x, float y, float m, color c) {
    skin = c;
    mass = m;
    diameter = m * 10;
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
    location.add(velocity);

    if( location.x <= 0 || location.x >= width ) velocity.x *= -1;
    if( location.y <= 0 || location.y >= height ) velocity.y *= -1;

    acceleration.mult(0);
  }

  void display () {
    fill(skin);
    stroke(255);
    ellipse( location.x, location.y, diameter, diameter );
  }
}




Balloon[] balloons;
PVector gravity = new PVector(0, 0.7);

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
