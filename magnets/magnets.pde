//PVector point1;
//PVector point2;
int pointsTotal = 100;
PVector[] points = new PVector[pointsTotal];
int[] colors = new int[pointsTotal];
void setup() {
  colorMode(HSB,100);
  size(600, 600);
  background(0,0,100);
  //point1 = new PVector(100, 300);
  //point2 = new PVector(500, 300);
  noFill();
  strokeWeight(1);
  stroke(247, 49, 135, 10);
  //point(point1.x, point1.y);
  //point(point2.x, point2.y);
  for (int i = 0; i < pointsTotal; i++) {
    points[i] = new PVector(random(600), random(600));
    ellipse(points[i].x, points[i].y, 20, 20);
    colors[i] = color(random(20,70), random(70,100), random(50,100));
  }
}
void draw() {

  for (int i = 0; i < 100; i++) {
    drawSegment(random(600), random(600));
  }
}
void drawSegment(float x, float y) {
  float dx = 0;
  float dy = 0;
  float d;
  int least = -1;
  float mindist = Float.MAX_VALUE;
  for (int i = 0; i < points.length; i++) {
    d = dist(x, y, points[i].x, points[i].y);
    if (mindist > d) {
      least = i;
      mindist = d;
    }
    if ((i & 1) == 0) {
      dx += (points[i].x - x)/d/d;
      dy += (points[i].y - y)/d/d;
    } else {
      dx += -(points[i].x - x)/d/d;
      dy += -(points[i].y - y)/d/d;
    }
  }
  strokeWeight(20);
  stroke(colors[least],5);
  //dx += -(point2.x - x)/d2/d2;
  //dy += -(point2.y - y)/d2/d2;
  dx *= 1000;
  dy *= 1000;
  //line(x, y, x+dx, y+dy);
  ellipse(x+dx,y+dy,mindist*5,mindist*5);
  //line(x,y,point1.x,point1.y);
}
void keyPressed() {
  if (key == '1') {
    saveFrame("frame" + (int)random(1000,9999) + ".png");
  }
}
