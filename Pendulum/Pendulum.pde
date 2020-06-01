PVector prevpos;
PVector pos;
PVector center = new PVector(300, 300);
PVector testpos;
float dt = 1; //delta time
void setup() {
  print(Float.MIN_VALUE);
  size(600, 600);
  float ran = 0;
  prevpos = new PVector(cos(ran)*200+300, sin(ran)*200+300);
  pos = new PVector(cos(ran)*200+300, sin(ran)*200+300);
  pixelDensity(1);
}

void draw() {
  background(255);
  line(300, 300, pos.x, pos.y);
  ellipse(pos.x, pos.y, 30, 30);
  //println(pos.x + " " + pos.y);
  //ellipse(p.x, p.y, 30, 30);
  for (int i = 0; i < (1/dt); i++) {
    PVector vel = PVector.sub(pos, prevpos);
    pos.add(PVector.mult(vel, dt));
    prevpos.add(PVector.mult(vel, dt));
    pos.add(0*dt, 1*dt);
    pos = PVector.add(center, PVector.mult(PVector.sub(pos, center), (200.0/pos.dist(center))));
  }
}
