size(360,360);
background(255);
noiseDetail(8, 0.46);
loadPixels();
float xoff = 0.3;
 
for (int x = 0; x < width; x++) {
  float yoff = 0.2;
 
  for (int y = 0; y < height; y++) {
    float bright = map(noise(xoff,yoff),0,1,0,255);
    if( bright < 80 ) {
      pixels[x+y*width] = color( 190, 150, 255 - bright );
    } else {
      pixels[x+y*width] = color( 120, bright, 120 );
    }
    yoff += 0.01;
  }
  xoff += 0.01;
}
updatePixels();