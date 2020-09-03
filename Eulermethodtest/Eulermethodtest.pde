//f(x) = sin x
int sc = 50;
void setup() {
  size(600, 600);
}
float ts = 1;
void draw() {
  background(255);
  for (int i = 0; i < 10; i++) {
    drawts(ts);
    ts /= 2;
  }
  noLoop();
}
void drawts(float ts) {
  PVector pos = new PVector(0, 0);
  PVector pos2;
  PVector temp;
  for (int i = 0; i < (600.0/sc)/ts; i++) {
    pos2 = new PVector(pos.x+ts, pos.y+ts*(2*pos.x));
    line(pos.x*sc, pos.y*sc, pos2.x*sc, pos2.y*sc);
    temp = pos;
    pos = pos2;
    pos2 = temp;
  }
}
