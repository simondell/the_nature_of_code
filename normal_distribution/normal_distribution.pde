import java.util.Random;

Random generator;
 
void setup() {
  size(640,360);
  generator = new Random();
}

void draw() {
//Note that nextGaussian() returns a double.
  float num = (float) generator.nextGaussian();
  float sd = 60;
  float mean = 320;
 
//Multiply by the standard deviation and add the mean.
  float x = sd * num + mean;
 
  noStroke();
  fill(255,10);
  ellipse(x,180,16,16);

}