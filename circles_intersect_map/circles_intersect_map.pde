//submission for:
//https://www.reddit.com/r/generative/comments/e12s8n/community_exhibition/


Circle[] circles;
int a = 2000;

float arcsin[] = new float[2*a+1];
int minradius = 30;
int maxradius;
int num = 100;
Sampler s = new Sampler();
void setup() {
  //blendMode(ADD);
  background(0);
  noStroke();

  for (int i = -a; i < a+1; i++) {
    arcsin[i+a] = asin((float)i/a);
    //System.out.println(asin((float)i/100));
  }
  size(600, 600);
  maxradius = width/20;
  circles = new Circle[num];
  pixelDensity(displayDensity());
  for (int i = 0; i < num; i++) {
    circles[i] = new Circle(random(0, width), random(0, height), random(minradius, maxradius), random(0, TAU), random(3, 5), s.nextSample()*100);
  }
}

void draw() {
  /*
  background(255);
   stroke(0);
   noFill();
   ellipse(200,200,100,100);
   ellipse(400,400,150,150);
   ellipse(mouseX,mouseY,125,125);
   fill(255,0,0);
   circlesOverlap(mouseX,mouseY,62.5,400,400,75);
   circlesOverlap(mouseX,mouseY,62.5,200,200,50);
   */

  blendMode(ADD);
  colorMode(RGB, 256);
  //background(0);


  for (int i = 0; i < num; i++) {
    circles[i].move();
    //circles[i].show();
  }

  colorMode(HSB, 100);
  for (int i = 0; i < circles.length-1; i++) {
    for (int j = i+1; j < circles.length; j++) {
      Circle a = circles[i];
      Circle b = circles[j];
      fill((a.c+b.c)%100, 100, 100, 2);
      //fill(0, 0, 1);
      circlesOverlap(a.x, a.y, a.r, b.x, b.y, b.r);
    }
  }
}

void circlesOverlap(float x1, float y1, float r1, float x2, float y2, float r2) {

  if (!(x1+r1<x2-r2)) {
    if (!(y1+r1<y2-r2)) {
      float distsquare = ((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2));
      if ((distsquare) < (r2-r1)*(r2-r1)&&r1>r2) {
        ellipse(x2, y2, r2+r2, r2+r2);
      } else if ((distsquare) < (r1-r2)*(r1-r2)&&r2>r1) {
        ellipse(x1, y1, r1+r1, r1+r1);
      } else if (distsquare<(r1+r2)*(r1+r2)) {
        float d = sqrt(distsquare);
        float b = ((r2*r2)-(r1*r1)+(d*d))/(2*d);
        float a = d-b;
        float h = sqrt(r1*r1-a*a);
        a = a/d;
        h = h/d;
        float int1x = x1+(a)*(x2-x1)-(h)*(y2-y1);
        float int1y = y1+(a)*(y2-y1)-(h)*(x1-x2);
        float int2x = x1+(a)*(x2-x1)+(h)*(y2-y1);
        float int2y = y1+(a)*(y2-y1)+(h)*(x1-x2);
        float temp = 0;
        if (getAngle(x1, y1, int2x, int2y)>getAngle(x1, y1, int1x, int1y)) {
          temp = TWO_PI;
        }
        arc(x1, y1, r1*2, r1*2, getAngle(x1, y1, int2x, int2y), temp + getAngle(x1, y1, int1x, int1y), OPEN);
        temp = 0;
        if (getAngle(x2, y2, int1x, int1y)>getAngle(x2, y2, int2x, int2y)) {
          temp = TWO_PI;
        }
        arc(x2, y2, r2*2, r2*2, getAngle(x2, y2, int1x, int1y), temp + getAngle(x2, y2, int2x, int2y), OPEN);
      }
    }
  }
}
//https://www.desmos.com/calculator/gbpyskmd7i
float getAngle(float x2, float y2, float x1, float y1) {
  float d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
  if (x1>x2) {
    return arcsine((y1-y2)/d);
  } else {
    return PI-arcsine((y1-y2)/d);
  }
}
float arcsine(float j) {
  //return asin(j);
  float s = map(j, -1, 1, 0, 2*a);
  if (s == floor(s)) {
    return arcsin[(int)s];
  }
  return map(s, floor(s), ceil(s), arcsin[floor(s)], arcsin[ceil(s)]);
}
//press 1 for save frame
void keyPressed() {
  if (key == '1') {
    saveFrame();
  }
}
