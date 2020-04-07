import java.util.*; //<>// //<>//

void setup() {
  pixelDensity(displayDensity());
  size(600, 600);
  strokeWeight(1);
  noFill();
  background(0);
  stamp(0, 0, 61, 61, 10);
}
void draw() {
}

void stamp(float x, float y, int w, int h, float s) {
  //rect(x, y, w*s-s, h*s-s);
  for (int i = 0; i < w; i++) {
    for (int j = 0; j < h; j++) {
      //ellipse(x+i*s, y+j*s, 2, 2);
      if (i != 0) {
        if (j != w-1) {
          if (random(1) < 0.2) {
            //line(x+i*s, y+j*s, x+i*s-s, y+j*s+s);
            //println((x+i*s)+" s "+(y+i*s));
            randiag(x+i*s, y+j*s, s, true);
          }
        }
      }
      if (i != w-1) {
        if (j != w-1) {
          if (random(1) < 0.2) {
            //line(x+i*s, y+j*s, x+i*s+s, y+j*s+s);
            randiag(x+i*s, y+j*s, s, false);
          }
        }
        if (random(1) < 0.2) {
          //line(x+i*s, y+j*s, x+i*s+s, y+j*s);
          rs(x+i*s, y+j*s, s, false);
        }
      }
      if (j != h-1) {
        if (random(1) < 0.2) {
          //line(x+i*s, y+j*s, x+i*s, y+j*s+s);
          rs(x+i*s, y+j*s, s, true);
        }
      }
    }
  }
}
void randiag(float x, float y, float s, boolean j) {

  if (j) {
    stroke(255, 0, 0);
    stroke(255);
    if (random(1)>0.3333) {
      line(x, y, x-s, y+s);
    } else if (random(1)>0.5) {

      arc(x-s, y, s+s, s+s, 0, PI/2);
    } else {
      arc(x, y+s, s+s, s+s, PI, PI+PI/2);
    }
  } else {
    stroke(0, 0, 255);
    stroke(255);
    if (random(1)>0.3333) {
      line(x, y, x+s, y+s);
    } else if (random(1)>0.5) {
      arc(x+s, y, s+s, s+s, PI/2, PI);
    } else {

      arc(x, y+s, s+s, s+s, PI+PI/2, 0);
    }
  }
  stroke(0);
  //noStroke();
}
void rs(float x, float y, float s, boolean ver) {
  if (ver) {
    stroke(0, 255, 0);
    stroke(255);
    if (random(1)>0.3333) {
      line(x, y, x, y+s);
    } else if (random(1)>0.5) {
      arc(x, y+s/2, s, s, PI/2, PI+PI/2);
    } else {   
      arc(x, y+s/2, s, s, PI+PI/2, TAU+PI/2);
    }
  } else {
    stroke(255, 0, 255);
    stroke(255);
    if (random(1)>0.3333) {
      line(x, y, x+s, y);
    } else if (random(1)>0.5) {
      arc(x+s/2, y, s, s, 0, PI);
    } else {   
      arc(x+s/2, y, s, s, PI, PI*2);
    }
  }
}
class Point {
  int x; 
  int y; 
  Point(int x_, int y_) {
    this.x = x_; 
    this.y = y_;
  }

  public boolean equals(Object a) {
    if (this == a) {
      return true;
    }
    if (a == null) {
      return false;
    }
    if (getClass() != a.getClass()) {
      return false;
    }
    Point aa = (Point)a; 
    if (this.x == aa.x) {
      if (this.y == aa.y) {
        return true;
      }
    }
    return false;
  }
  //public int hashCode(){
  //  return (1 << x) << 15 | 1 << y;
  //}
  //public int compare(Point a, Point b) {
  //  if (a.x < b.x) {
  //    return -1;
  //  } else if (a.x > b.x) {
  //    return 1;
  //  }
  //  if (a.y < b.y) {
  //    return -1;
  //  } else if (a.y > b.y) {
  //    return 1;
  //  }
  //  return 0;
  //}
  //@Override
  //public int compareTo(Point a) {
  //  if (this.x < a.x) {
  //    return -1;
  //  } else if (this.x > a.x) {
  //    return 1;
  //  }
  //  if (this.y < a.y) {
  //    return -1;
  //  } else if (this.y > a.y) {
  //    return 1;
  //  }
  //  return 0;
  //}
}
void keyPressed() {
  if (key == '1') {
    saveFrame();
  }
}
