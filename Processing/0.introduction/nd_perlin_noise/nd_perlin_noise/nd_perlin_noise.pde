void setup(){
  size(360,360);
  background(255);
  noiseDetail(2,0.555);
}

float t = 0.01;

void draw(){
  loadPixels();
  float xoff = 0.5;
  
  for (int x = 0; x < width; x++) {
    float yoff = 0.5;
   
    for (int y = 0; y < height; y++) {
      float bright = map(noise(xoff,yoff, t),0,1,0,255);
      pixels[x+y*width] = color( bright / 1.5, 255 - bright, bright * 0.8 );
      yoff += 0.015;
    }
    xoff += 0.015;
    t += 0.00002;
  }
  updatePixels();
}