PVector pos;
PVector center = new PVector(300, 300);
PVector n;
void setup() {

  size(600, 600);
}
void draw() {
  background(255);
  pos = new PVector(mouseX,mouseY);
  n = PVector.add(center, PVector.mult(PVector.sub(pos, center), (200.0/pos.dist(center))));
  ellipse(pos.x,pos.y,10,10);
  ellipse(300,300,10,10);
  ellipse(n.x,n.y,10,10);
}
