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

//
// event handlers
//
void setup () {
  size( 640, 396 );

  balloons = new Balloon[100];

  int len = balloons.length;
  for( int i = 0; i < len; i++ ) {
	  balloons[i] = balloonFactory( random(width), random(height), 10 );
  }
}

void draw () {
  background(255);

  int len = balloons.length;
  for( int i = 0; i < len; i++ ) {
    edgeEffect( balloons[i] );
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
  shove.mult(random(-10, 10));
  b.applyForce( shove );
  return b;
}

void edgeEffect(Balloon balloon) {
  PVector dn = PVector.sub( new PVector( balloon.location.x, 0 ), balloon.location );
  PVector de = PVector.sub( new PVector( width, balloon.location.y ), balloon.location );
  PVector ds = PVector.sub( new PVector( balloon.location.x, height ), balloon.location );
  PVector dw = PVector.sub( new PVector( 0, balloon.location.y ), balloon.location );

  PVector fn = PVector.mult( dn.div(1000), 1 / dn.mag() * dn.mag() );
  PVector fe = PVector.mult( de.div(1000), 1 / de.mag() * de.mag() );
  PVector fs = PVector.mult( ds.div(1000), 1 / ds.mag() * ds.mag() );
  PVector fw = PVector.mult( dw.div(1000), 1 / dw.mag() * dw.mag() );

  balloon.applyForce( fn );
  balloon.applyForce( fe );
  balloon.applyForce( fw );
  balloon.applyForce( fs );
}
