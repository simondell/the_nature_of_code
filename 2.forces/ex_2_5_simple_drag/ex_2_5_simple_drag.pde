//
// constants
//
color bg = #ff530d;
color yellow = #fff245;
color tan = #e8ba64;
color puce = #E8095B;
color purple = #B94FFF;

enum HighlightState { DONT,RESISTED,ACCELERATED }



//
// classes
//
class Balloon {
  PVector location, velocity, acceleration;
  float radius;
  float mass;
  HighlightState highlight;

  Balloon (float x, float y, float m) {
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
        case RESISTED: c = puce; break;
        case ACCELERATED: c = purple; break;
        default: c = tan;
    }

    noStroke();
    fill(c);
    ellipse( location.x, location.y, radius * 2, radius  * 2 );
  }

  boolean isInside(Liquid l) {
    // This conditional statement determines if the PVector location is inside the rectangle defined by the Liquid class.
    // if (location.x>l.x && location.x<l.x+l.w && location.y>l.y && location.y<l.y+l.h)
    // {
    //   return true;
    // } else {
    //   return false;
    // }

    return (location.x>l.x && location.x<l.x+l.w && location.y>l.y && location.y<l.y+l.h);
  }

  void drag(Liquid l) {
    float speed = velocity.mag();
    // The force’s magnitude: Cd * v~2~
    float dragMagnitude = l.c * speed * speed;

    PVector drag = velocity.get();
    drag.mult(-1);
    // The force's direction: -1 * velocity
    drag.normalize();

    // Finalize the force: magnitude and direction together.
    drag.mult(dragMagnitude);

    // Apply the force.
    applyForce(drag);
  }
}



class Liquid {
  // The liquid object includes a variable defining its coefficient of drag.
  float x,y,w,h;
  float c;

  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    c = c_;
  }

  void display() {
    noStroke();
    fill(purple);
    rect(x,y,w,h);
  }
}



// Variables
Balloon[] balloons;
Liquid liquid;
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

  liquid = new Liquid(0, 2 * height / 3, width, height/3, 0.4);
}

void draw () {
  background(bg);

  liquid.display();

  int len = balloons.length;
  for( int i = 0; i < len; i++ ) {
    balloons[i].highlight = HighlightState.DONT;
    balloons[i].applyForce( gravity );
    if (balloons[i].isInside(liquid)) {
      balloons[i].drag(liquid);
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
Balloon balloonFactory (float x, float y, float m) {
  PVector shove;
  Balloon b = new Balloon( x, y, m );

  shove = PVector.random2D();
  shove.mult(random(20));
  b.applyForce( shove );
  return b;
}


