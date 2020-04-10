Turn[] s = new Turn[1];
void setup() {
  size(300, 300);
}

void draw() {
  noFill();
  background(255);
  Turn a = new Turn(mouseX, mouseY, 50, PI/2);
  stroke(0);
  ellipse(275, 275, 2, 2);
  if (a.turn(275, 275)) {
    stroke(255, 0, 0);
  }
  for (int i = -1; i < 2; i++) {
    for (int j = -1; j < 2; j++) {
      ellipse(mouseX+i*300, mouseY+j*300, 100, 100);
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
  boolean turn(float mx, float my) {
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
    float angle = getAngle(x,y,x+dx,y+dy);
    float d = sqrt(dx*dx+dy*dy);
    if (d<r) {
      
      line(x,y,x+dx,y+dy);
      stroke(0,255,0);
      line(x,y,x+d*cos(angle+deg),y+d*sin(angle+deg));
      return true;
    }
    return false;
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
