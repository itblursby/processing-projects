final float R3 = sqrt(3);
PVector p1;
PVector p2; 
float t = 0;
float sint;
float cost;
final int ITERATIONS = 6;
void setup() {
  size(600, 600, P2D);
  p1 = new PVector(300+sin(TAU*1./3.)*150, 300-cos(TAU*1./3.)*150);
  p2 = new PVector(300+sin(TAU*2./3.)*150, 300-cos(TAU*2./3.)*150);
  noStroke();
  fill(255, 0, 0);
  blendMode(DARKEST);
  frameRate(60);
}
void draw() {

  t += 0.01;
  //t = PI*2/3.;
  sint = sin(t);
  cost = cos(t);
  background(255);
  //ellipse(300, 300, 3, 3);
  //line(p1.x, p1.y, p2.x, p2.y);
  drawThelp(p1.x, p1.y, p2.x, p2.y, ITERATIONS);
  //drawT(p1.x,p1.y,mouseX,mouseY,6);
}
void drawThelp(float x1, float y1, float x2, float y2, int c) {
  //if (c <= 0) {
  //  return;
  //}
  float x3, y3;
  x3 = (x1+x2)*0.5-R3*(y2-y1)*0.5;
  y3 = (y1+y2)*0.5+R3*(x2-x1)*0.5;
  //triangle(x1, y1, x2, y2, x3, y3);
  drawT1(x1, y1, x2, y2, x3, y3, c);
  //drawT(((x1+x3)-x2-x1))*0.5, ((y1+y3)-(y2-y1))*0.5, (x1+x3)*0.5, (y1+y3)*0.5, c-1);
  //drawT((x2+x3)*0.5, (y2+y3)*0.5, ((x2+x3)+(x2-x1))*0.5, ((y2+y3)+(y2-y1))*0.5, c-1);
  //drawT((x1+x2)*0.5, (y1+y2)*0.5, ((x1+x2)+(x1-x3))*0.5, ((y1+y2)+(y1-y3))*0.5, c-1);
}
void drawT1(float x1, float y1, float x2, float y2, float x3, float y3, int c) {
  if (c <= 0) return;
  if (c < ITERATIONS) {
    triangle(x1, y1, x2, y2, x3, y3);
  }
  fill(255, 255, 0);
  drawT2(x1, y1, x2, y2, x3, y3, c);
  fill(0, 255, 255);
  drawT2(x3, y3, x1, y1, x2, y2, c);
  fill(255, 0, 255);
  drawT2(x2, y2, x3, y3, x1, y1, c);


  //float mx = (x1+x2)*0.5, my = (y1+y2)*0.5;
  //drawT1(mx, my, (x1-x3)*0.5+mx, (y1-y3)*0.5+my, (x2-x3)*0.5+mx, (y2-y3)*0.5+my, c-1);
}
void drawT2(float x1, float y1, float x2, float y2, float x3, float y3, int c) {
  float mx = (x1+x2)*0.5, my = (y1+y2)*0.5;
  float d1x = (x1-x3)*0.5;
  float d1y = (y1-y3)*0.5;
  float d2x = (x2-x3)*0.5;
  float d2y = (y2-y3)*0.5;
  drawT1(mx, my, mx+cost*d1x-sint*d1y, my+sint*d1x+cost*d1y, mx+cost*d2x-sint*d2y, my+sint*d2x+cost*d2y, c-1);
}
