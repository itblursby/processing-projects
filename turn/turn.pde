Turn[] s = new Turn[100];
int reso = 1;
void setup() {
  //pixelDensity(displayDensity());
  size(600, 600);
  strokeWeight(1);
  noFill();
  
  for (int i = 0; i < s.length; i++) {
    s[i] = new Turn(random(width), random(height), random(min(width, height)/4), random(2*PI));
  }
}
int pos = 0;
void draw() {
  for (int i = 0; i < 200; i++) {
    pos++;
    pointAt(pos%(width*reso), pos/(height*reso));
  }
  //for (int i = 0; i < width; i++) {
  //  for (int j = 0; j < height; j++) {
  //    pointAt(i,j);
  //    //float[] p = new float[] {i, j};
  //    //for (int e = 0; e < s.length; e++) {
  //    //  p = s[e].turn(p[0], p[1]);
  //    //}

  //    //fill(0, 255*p[0]/300, 255*p[1]/300);
  //    //rect(i, j, 1, 1);
  //  }
  //}
  if (pos > width*height*reso*reso){
    noLoop();
    saveFrame();
  }
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
    if (dx > width/2) {
      dx = -(width - dx);
    } else if (dx < -width/2) {
      dx = -(-width - dx);
    }
    float dy = my - y;
    if (dy > height/2) {
      dy = -(height - dy);
    } else if (dy < -height/2) {
      dy = -(-height - dy);
    }
    float angle = getAngle(x, y, x+dx, y+dy);
    float d = sqrt(dx*dx+dy*dy);
    if (d<r) {

      //line(x, y, x+dx, y+dy);
      //stroke(0, 255, 0);
      //line(x, y, x+d*cos(angle+deg), y+d*sin(angle+deg));
      return new float[]{mod(x+d*cos(angle+deg), width), mod(y+d*sin(angle+deg), height)};
    }
    return new float[]{mx, my};
  }
}
float getAngle(float x2, float y2, float x1, float y1) {
  float d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
  if (x1>x2) {
    return asin((y1-y2)/d);
  } else {
    return PI-asin((y1-y2)/d);
  }
}
float mod(float a, float b) {
  return (a % b + b) % b;
}
void pointAt(float x, float y) {
  float[] p = new float[] {x, y};
  for (int e = 0; e < s.length; e++) {
    p = s[e].turn(p[0], p[1]);
  }

  stroke(255*p[0]/width, 255*p[1]/height, 255);
  point(x, y);
}
