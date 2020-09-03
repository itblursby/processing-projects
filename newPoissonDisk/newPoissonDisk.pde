int size = 20;
PoissonDisk pd = new PoissonDisk(300, 300, size);
void setup() {
  pixelDensity(displayDensity());
  size(600, 600);
  background(255);

  //for (int i = 0; i < width/size; i++) {
  //  line(i*size, 0, i*size, height);
  //}
  //for (int i = 0; i < height/size; i++) {
  //  line(0, i*size, width, i*size);
  //}
  strokeWeight(size);
  stroke(255, 0, 0);
}
int x = 0;
void draw() {
  //background(255);
  //println("x:"+x);
  x++;
  for (int i = 0; i < 1000; i++) {
    PVector s = pd.next();
    point(s.x, s.y);
  }
  noLoop();
}
