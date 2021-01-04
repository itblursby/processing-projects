int size = 10;
PoissonDisk pd = new PoissonDisk(300, 300, size);
void setup() {
  pixelDensity(displayDensity());
  size(600, 600);
  background(255);
  noStroke();
  fill(0);
  //strokeWeight(1);
  //stroke(1);
  //noFill();
  ellipse(300, 300, size, size);
}
int x = 0;
void draw() {
  //background(255);
  //println("x:"+x);
  x++;
  for (int i = 0; i < 1000; i++) {
    PVector s = pd.next();
    ellipse(s.x, s.y, size, size);
  }
  noLoop();
}
