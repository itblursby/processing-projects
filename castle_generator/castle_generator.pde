float scale = 1;

float ph = 10; //parapet height

float minw = 50; //minimum width of tower

float winspace = 25;
float winwid = 10;

//float minh = 30; // min height
//float maxh = 60;  // max height

float maxwr = 0.7; // max width ratio
float minwr = 0.3; // min width ratio

float maxhr = 1.1; // max height ratio
float minhr = 0.7; // min height ratio

 
void setup() {
  ph *= scale;
  minw *= scale;

  size(600, 600);
  pixelDensity(displayDensity());
  stroke(0);
  strokeWeight(1);
  fill(255);
  frameRate(3);
}

void draw() {
  background(255, 0, 0);
  castle(50, 500, 500, 80);
  // line(0, 50, 900, 50);
  //noLoop();
}
void parapet(float x, float y, float le) {
  noStroke();
  fill(255);
  int t = round(le/ph);
  float l = le/(2*t);
  rect(x-l/2, y-(ph/4), le+l, (ph*0.5));
  for (int i = 0; i < t+1; i++) {
    rect((x-l/2)+l*i*2, y-(ph*0.75), l, ph*0.5);
  }
  stroke(0);
  line(x-l/2, y+(ph*0.25), x+l/2+le, y+(ph*0.25));
  for (int i = 0; i < t+1; i++) {
    //rect((x-l/2)+l*i*2, y-11, l, 10);
    line((x-l/2)+l*i*2, y-(ph*0.75), (x-l/2)+l*i*2+l, y-(ph*0.75));
    if (i == 0) {
      line((x-l/2), y-(ph*0.75), (x-l/2), y+(ph*0.25));
    }  
    if (i != t) {
      line((x-l/2)+l*i*2+l, y-(ph*0.75), (x-l/2)+l*i*2+l, y-(ph*0.25));
      line((x-l/2)+l*i*2+l, y-(ph*0.25), (x-l/2)+l*i*2+l+l, y-(ph*0.25));
      line((x-l/2)+l*i*2+l+l, y-(ph*0.25), (x-l/2)+l*i*2+l+l, y-(ph*0.75));
    }
  }
  line(x-l/2+le+l, y-(ph*0.75), x-l/2+le+l, y+(ph*0.25));
}
void castlerect(float x, float y, float w, float h) {
  stroke(0);
  fill(255);
  rect(x, y, w, h);
  parapet(x, y, w);
}
void castle(float x, float y, float w, float h) {
  rect(x, y, w, h);
  if (w > minw) {
  
    int r = floor(random(2, 4));
    BestCandidate s = new BestCandidate(3, 10, x, x+w);
    for (int i = 0; i < r; i++) {
      float nw = random(minwr, maxwr)*w;
      float nh = random(minhr, maxhr)*h;
      float nx = s.nextSample(x, x+w-nw);
      if (nw < minw) {
        if (random(1)>0.1) {
          castle(nx, y-nh, nw, nh);
        } else {
          tower(nx, y-nh*2, nw, nh*2);
        }
      } else {
        castle(nx, y-nh, nw, nh);
      }
    }
  }
  //print(w > minw);
  windows(x,y,w,h);
  parapet(x, y, w);
}
void keyPressed() {
  if (key == '1') {
    saveFrame();
  }
}
void tower(float x, float y, float w, float h) {
  float f = random(1, 1.7);
  rect(x, y-h*f+h, w, h*f);
  triangle(x, y-h*f+h, x+w, y-h*f+h, x+w*0.5, y-h*f+h-w*random(1, 3));
}
void windows(float x, float y, float w, float h){
  float[] v = divide(w,(winspace)*scale);
  for (int i = 1; i < v[0]; i++){
    rect(x+i*v[1]-winwid*scale/2,y+scale*h/4,winwid*scale,scale*h/4);
  }
}
float[] divide(float len, float div){
  int q = round(len/div);
  return new float[]{q, len/q};
}
