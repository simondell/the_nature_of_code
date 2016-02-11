import java.util.Random;

Random generator;
int red, green, blue;

void setup() {
  size(640,360);
  noStroke();
  generator = new Random();
}

float gaussian( float mu, float sigma ) {
  float num = (float) generator.nextGaussian();
  float ret = sigma * num + mu;

  return ret;
}

void draw() {
  if( !mousePressed ) return;

  float x = gaussian( mouseX, 10 );
  float y = gaussian( mouseY, 10 ); 
  ellipse( x, y, 8, 8 );
}

void mousePressed() {
  red = (int) gaussian( 125, 60 ); 
  green = (int) gaussian( 125, 60 ); 
  blue = (int) gaussian( 125, 60 ); 
  fill( red, green, blue, 80 );
}