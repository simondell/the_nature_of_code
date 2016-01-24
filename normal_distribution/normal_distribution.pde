import java.util.Random;

Random generator;

void setup() {
  size(640,360);
  generator = new Random();
}

float gaussian( float mu, float sigma ) {
  float num = (float) generator.nextGaussian();
  float ret = sigma * num + mu;

  return ret;
}

void draw() {
  noStroke();

  int red = (int) gaussian( 125, 60 ); 
  int green = (int) gaussian( 125, 60 ); 
  int blue = (int) gaussian( 125, 60 ); 
  fill( red, green, blue, 50 );

  float x = gaussian( 320, 60 );
  float y = gaussian( 180, 60 ); 
  ellipse( x, y, 8, 8 );
}