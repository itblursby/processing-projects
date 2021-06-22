int un = 2;

void setup() {
  size(600, 600);
  pixelDensity(displayDensity());
  colorMode(HSB, 200);
  background(0, 0, 200);
  stroke(0, 0, 200);
  strokeCap(ROUND);
}

void draw() {
  //circle2(random(200, 400), random(200, 400), 600);
  //segments(random(200, 400),random(200, 400),0,0,20);
  //noLoop();
  for (int i = 0; i < 10; i++) {
    rects(((int)random(-100/un, 700/un))*un, ((int)random(-100/un, 700/un))*un, ((int)random(200/un))*un-100, ((int)random(500/un))*un-100);
  }
  //if (frameCount % 100 == 0) {
  //  saveFrame("output1/#####.tif");
  //}
  //rects(mouseX,mouseY,100,100);
}
void segments(float x, float y, float dx, float dy, int q) {
  float cx = x;
  float cy = y;
  for (int i = 0; i < q; i++) {
    float an = random(TAU);
    float rdx = dx + 50*cos(an);
    float rdy = dy + 50*sin(an);
    line(cx, cy, cx+rdx, cy+rdy);
    cx += rdx;
    cy += rdy;
  }
}
void rects(float x, float y, float w, float h) {
  fill(random(200), 20, random(600-y));
  noStroke();
  //strokeWeight(1);
  //stroke(0);
  int rects = 0;
  if (random(1)>0.5) {
    float xn = x;
    while (xn < x +w) {
      //if (rects % 2) == 0
      float cw = (int)random(5)*un;
      if (rects % 2 == 0) {
        rect(xn, y, min(cw, x+w-xn), h);
      }
      xn += cw;
      y += (int)random(-20, 21)*un;
      rects++;
    }
  } else {

    float yn = y;
    while (yn < y +h) {
      //if (rects % 2) == 0
      float cw = (int)random(5)*un;
      if (rects % 2 == 0) {
        rect(x, yn, w, min(cw, y+h-yn));
      }
      yn += cw;
      x += (int)random(-20, 21)*un;
      //rects++;
    }
  }
}
void circle2(float x, float y, float size) {
  //stroke(0, 0, 0);
  //strokeWeight(size);
  //line(x, y-l, x, y+l);
  if (size <= 40) {
    if (random(1) > 0.1) {
      if (random(1) > 0.9) {
        stroke(random(200), 100, 170);
      }
    } else {
      stroke(0, 0, 200);
    }
    //strokeWeight(size);
    //strokeWeight(random(1, 2));
    strokeWeight(size);
    int d = 30;

    line(x, y, x + np()*30, y + np()*30);
  }
  if (size > 10) {
    int d = 50;
    circle2(x+random(-d, d), y+random(-d, d), size*random(0.4, 0.6));
    circle2(x+random(-d, d), y+random(-d, d), size*random(0.4, 0.6));
  }
}
void keyPressed() {
  if (key == '1') {
    noLoop();
  } else if (key == '2') {
    loop();
  } else if (key == 'p') {
    saveFrame();
  }
}
int np() {
  return random(1)>0.5?-1:1;
}
