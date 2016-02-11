float x = 100;
float y = 100;
float xspeed = 1;
float yspeed = 3.3;
 
//Remember how Processing works? setup() is executed once when the sketch starts and draw() loops forever and ever (until you quit).
void setup() {
  size(640,360);
  stroke(0);
  fill(175);
}
 
void draw() {
//Move the ball according to its speed.
  x = x + xspeed;
  y = y + yspeed;
 
//Check for bouncing.
  if ((x > width) || (x < 0)) {
    xspeed = xspeed * -1;
  }
  if ((y > height) || (y < 0)) {
    yspeed = yspeed * -1;
  }
 
//Display the ball at the location (x,y).
  background(255);
  ellipse(x,y,32,32);
}