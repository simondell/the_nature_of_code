int[] randomCounts;
 
void setup() {
  size(640,240);
  randomCounts = new int[20];
}
 
void draw() {
  background(255);
 
// Pick a random number and increase the count.
  int index = int(random(randomCounts.length));
  randomCounts[index]++;
 
  stroke(0);
  fill(175);
  int w = width/randomCounts.length;
//Graphing the results
  for (int x = 0; x < randomCounts.length; x++) {
    rect(x*w,height-randomCounts[x],w-1,randomCounts[x]);
  }
}