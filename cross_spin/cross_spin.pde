void setup() {
  size(400, 400);
  noStroke();
  pixelDensity(2);
}
int t = 0;
void draw() {
  
  if (t % 200 > 100) {
    background(255);
    fill(0);
    drawall(-50, -50, TAU*t/400);
  } else {
    background(0);
    fill(255);
    drawall(-130, -90, TAU*t/400);
  }
  t++;
  if (t == 200){
    t = 0;
  }
}
void drawCross(float x, float y, float a) {
  if (x-135 < width&&x + 135 > 0) {
    if (y-135 < height&&y + 135 > 0) {
      translate(x, y);
      rotate(a);
      rect(-20, -60, 40, 120);
      rect(-60, -20, 120, 40);
      rotate(-a);
      translate(-x, -y);
    }
  }
}
void drawall(float x_, float y_, float a) {
  float xt = x_;
  float yt = y_;
  float x = x_;
  float y = y_;
  int d = -1;
  for (int i = 0; i < 6; i++) {
    for (int j = 0; j < 9; j++) {
      drawCross(x, y, d*a);
      x += 120;
      y -= 40;
      d = -d;
    }
    d = -d;
    xt -= 80;
    yt += 160;
    x = xt;
    y = yt;
  }
}
