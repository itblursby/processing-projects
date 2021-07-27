class Traveler {
  float x, y, dx, dy, px, py;

  public Traveler() {
    float randAngle = random(TAU);
    float randRad = random(100, 300);
    x = cos(randAngle)*randRad + 300;
    y = sin(randAngle)*randRad + 300;
    px = x;
    py = y;
    randAngle = random(TAU);
    randRad = random(0, 20);
    dx = cos(randAngle)*randRad;
    dy = sin(randAngle)*randRad;
  }
  public void iterate() {
    px = x;
    py = y;
    x += dx;
    y += dy;
  }
  private void accel(float tx, float ty) {
    float accelc = 0.03;
    dx += (tx - x) * accelc;
    dy += (ty - y) * accelc;
  }
  public void display() {

    float d = dist(x, y, px, py);
    stroke(0, 0, 100);
    noStroke();
    float w = d;
    float random = 1;
    while (w > 0) {
      fill(9, 23+random(-10, 10), 77+random(-20, 20));
      if (random(1)>0.5) {
        blendMode(DARKEST);
      } else {
        blendMode(LIGHTEST);
      }
      ellipse((x+px)/2 + random(-random, random), (y+py)/2 + random(-random, random), w, w);
      w -= random(3, 6);
    }
  }
}
