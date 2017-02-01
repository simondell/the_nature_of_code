HighlightState highlightState;
enum HighlightState { DONT,RESISTED,ACCELERATED }

class Balloon {
  PVector location, velocity, acceleration;
  float radius;
  color skin;
  float mass;
  HighlightState highlight;

  Balloon (float x, float y, float m, color c) {
    skin = c;
    mass = m;
    radius = m * 5;
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
    color c;

    switch( highlight ) {
        case RESISTED: c = 0; break;
        case ACCELERATED: c = #ff0000; break;
        default: c = skin;
    }

    fill(c);
    stroke(c);
    ellipse( location.x, location.y, radius * 2, radius  * 2 );
  }
}


// CONSTANTS
final int X = 0;
final int Y = 1;
final int WIDTH = 2;
final int HEIGHT = 3;

// Variables
Balloon[] balloons;
PVector gravity = new PVector(0, 0.7);
PVector wind = new PVector(0.3, 0);
float mu = 0.8;
float um = 1.2;
float n = 1;

float w = 100;
float h = 100;
float[] resistor;
float[] accelerator;


//
// event handlers
//
void setup () {
  size( 640, 396 );

  resistor = new float[4];
  resistor[X] = width / 2 - w;
  resistor[Y] = height / 2 - h / 2;
  resistor[WIDTH] = w;
  resistor[HEIGHT] = h;

  accelerator = new float[4];
  accelerator[X] = width / 2;
  accelerator[Y] = height / 2 - h / 2;
  accelerator[WIDTH] = w;
  accelerator[HEIGHT] = h;

  balloons = new Balloon[1];

  int len = balloons.length;
  for( int i = 0; i < len; i++ ) {
    balloons[i] = balloonFactory( random(width), random(height), 10 );
  }
}

void draw () {
  background(255);

  fill(0);
  rect( resistor[X], resistor[Y], resistor[WIDTH], resistor[HEIGHT] );
  fill(#ff0000);
  rect( accelerator[X], accelerator[Y], accelerator[WIDTH], accelerator[HEIGHT] );

  int len = balloons.length;
  for( int i = 0; i < len; i++ ) {
    boolean resisted = false;
    boolean acclerated = false;

    balloons[i].highlight = HighlightState.DONT;
    balloons[i].applyForce( gravity );
    // balloons[i].applyForce( wind );

    resisted = overlap(balloons[i], resistor[X], resistor[Y], resistor[WIDTH], resistor[HEIGHT] );
    if( resisted ) {
        PVector friction = balloons[i].velocity.copy();
        friction.normalize();
        friction.mult(n * mu * -1);
        balloons[i].applyForce( friction );
        balloons[i].highlight = HighlightState.RESISTED;
    }

    acclerated = overlap(balloons[i], accelerator[X], accelerator[Y], accelerator[WIDTH], accelerator[HEIGHT] );
    if( acclerated ) {
        PVector boost = balloons[i].velocity.copy();
        boost.normalize();
        boost.mult(n * um);
        balloons[i].applyForce( boost );
        balloons[i].highlight = HighlightState.ACCELERATED;
    }

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
  return color(random(42, 255), random(42, 255), random(42, 255) );
}

Balloon balloonFactory (float x, float y, float m) {
  PVector shove;
  Balloon b = new Balloon( x, y, m, getRandomColor() );

  shove = PVector.random2D();
  shove.mult(random(20));
  b.applyForce( shove );
  return b;
}

boolean overlap(
    Balloon b,
    float x,
    float y,
    float w,
    float h
) {
    PVector p = new PVector();
    float max_x = x + w;
    float max_y = y + h;
    boolean overlap = false;

    for( float xi = x; xi <= max_x; xi += b.radius - 1 ) {
        for( float yi = y; yi <= max_y; yi += b.radius - 1 ) {
            p.x = xi;
            p.y = yi;
            if( p.sub(b.location).mag() < b.radius ) {
                overlap = true;
                break;
            }
        }
        if( overlap ) break;
    }

    return overlap;
}
