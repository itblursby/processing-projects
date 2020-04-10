Turn[] s = new Turn[50];
void setup() {
  size(300, 300);
  noStroke();
  for (int i = 0; i < s.length; i++){
    s[i] = new Turn(random(width),random(height),random(min(width,height)/2),random(2*PI));
  }
}
float b = 0;
void draw() {
  noFill();
  background(255);
  b += 0.01;
  Turn a = new Turn(300, 150, 50, b);
  for (int i = 0; i < width; i++){
    for (int j = 0; j < height; j++){
      
      float[] p = new float[] {i,j};
      for (int e = 0; e < s.length; e++){
        p = s[e].turn(p[0], p[1]);
      }
  
      fill(255*p[0]/300,255*p[1]/300,0);
      rect(i,j,1,1);
    }
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
      return new float[]{mod(x+d*cos(angle+deg),width),mod(y+d*sin(angle+deg),height)};
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
