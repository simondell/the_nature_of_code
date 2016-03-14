PVector sphere_center, velocity;
float radius = 50;

void setup() {
  size(640,640,P3D);
  sphere_center = new PVector(width/2, height/2, -300);
  velocity = new PVector(2.3, 4, -1.5);
}

void draw() {
  background(0);
  lights();

  PVector new_sphere_center = sphere_center.copy();
  new_sphere_center.add( velocity );
  if( new_sphere_center.x > width/2 + radius * 3
      || new_sphere_center.x < width/2 - radius * 3) velocity.x *= -1;
  
  if( new_sphere_center.y > height/2 + radius * 3
      || new_sphere_center.y < height/2 - radius * 3 ) velocity.y *= -1;

  if( new_sphere_center.z > height/2 + radius * 3
    || new_sphere_center.z < height/2 - radius * 3 ) velocity.z *= -1;

  sphere_center.add( velocity );

  drawBoxes();
  
  pushMatrix();
  translate(sphere_center.x, sphere_center.y, sphere_center.z);
  fill(200);
  noStroke();
  //rotateY(1.25);
  //rotateX(-0.4);
  sphere(radius);

  popMatrix();
}

void drawBoxes() {
  pushMatrix();
  translate(width/2, height/2, 0);
  //rotateY(1.25);
  //rotateX(-0.4);
  noFill();
  stroke(255);
  //box(100);
  box(radius * 6);
  popMatrix();
}