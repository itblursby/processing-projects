Turn[] s = new Turn[1];
void setup() {
  size(100, 100);
  for (int i = 0; i < s.length; i++){
  }
}

void draw() {
}
class Turn {
  float x;
  float y;
  float r;
  float deg;
  Turn(float x_, float y_, float r_, float deg_) {
    x = x_;
    y = y_;
    r = r_;
    deg = deg_;
  }
  float[] turn(float mx, float my) {
    float dx = mx - x;
    if (
  }
}
