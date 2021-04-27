final int ITERATIONS = 3;
final int circles = 10;
final float speed = .001f;
final float diameter = 20;
final float space = 10;
float angle = 0f;
void setup() {
  pixelDensity(displayDensity());
  size(600, 600);
  noStroke();
  fill(255, 0, 0);
}
void draw() {
  background(255);
  //fill(255,255,255,30);
  //rect(0,0,600,600);
  //translate(width/2., height/2.);
  angle += speed;
  //float rad = 0;
  drawAt(width/2, height/2, circles, diameter, space, ITERATIONS);
}
void drawAt(float x, float y, int circles, float diameter, float space, int iterations) {
  if (iterations == 0) {
    return;
  }
  for (int i = 0; i < circles; i++) {
    float s = map(i, 0, circles, 0, 200);
    fill(255, s, s);
    float cx = x+cos(angle*i)* space * i;
    float cy = y+sin(angle*i)* space * i;
    if (iterations == 1) {
      circle(cx, cy, diameter);
    }
    float next = diameter/(circles * space);
    drawAt(cx, cy, circles, diameter * next, space * next, iterations-1);
  }
}
