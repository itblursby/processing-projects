
class Circle {

  float x = 0;
  float y = 0;
  float radius = 1;
  float curve = 1;
  Circle(float x_, float y_, float d) {
    this.x = x_;
    this.y = y_;
    this.radius = d;
    this.curve = 1/d;
  }
  Circle(PVector l, float d) {
    this.x = l.x;
    this.y = l.y;
    this.radius = d;
    this.curve = 1/d;
  }
  boolean isOnScreen() {
    float r = abs(radius);
    if (x+r<0-r) {
      return false;
    }
    if (x-r>width+r) {
      return false;
    }
    if (y+r<0-r) {
      return false;
    }
    if (y-r>height+r) {
      return false;
    }
    return true;
  }
  PVector getLocation() {
    return new PVector(x, y);
  }
  float getRadius() {
    return radius;
  }
  //returns Circle with increased radius r
  Circle a(float r) {
    return new Circle(this.x, this.y, (this.radius)+r);
  }
  float getCurve() {
    return curve;
  }
  void display() {
    ellipse(x, y, abs(radius+radius), abs(radius+radius));
  }
  //Circle Intersection Math:
  //https://www.desmos.com/calculator/apmfyecn1k
  boolean hasIntersection(Circle b) {
    if (!(b.x+b.radius<x-radius||b.x-b.radius>x+radius)) {
      if (!(b.y+b.radius<y-radius||b.y-b.radius>y+radius)) {
        if ((x-b.x)*(x-b.x)+(y-b.y)*(y-b.y)<(radius+b.radius)*(radius+b.radius)) {
          return true;
        }
      }
    }
    return false;
  }
  PVector[] Intersections(Circle p) {
    //
    // c1(x1,y1,r1)
    // c2(x2,y2,r2)
    //
    // (x,y)
    //
    // dist(point(x,y), point(x1,y1)) = r1
    // dist(point(x,y), point(x2,y2)) = r2
    //
    // 
    //
    float d = sqrt((x-p.x)*(x-p.x)+(y-p.y)*(y-p.y));
    float b = (p.radius*p.radius-radius*radius+d*d)/(2*d);
    float a = d-b;
    float h = sqrt(radius*radius-a*a);
    a /= d;
    h /= d;
    PVector[] intersects = new PVector[2];
    intersects[0] = new PVector(x+a*(p.x-x)+h*(p.y-y), y+a*(p.y-y)+h*(x-p.x));
    intersects[1] = new PVector(x+a*(p.x-x)-h*(p.y-y), y+a*(p.y-y)-h*(x-p.x));
    return intersects;
  }
}
class DragCircle {
  float x = 0;
  float y = 0;
  float r = 1;
  boolean pmousePressed = true;
  boolean nmousePressed = true;
  boolean dragged = false;

  DragCircle(float x_, float y_) {
    this.x = x_;
    this.y = y_;
  }
  DragCircle(float x_, float y_, float r_) {
    this.x = x_;
    this.y = y_;
    this.r = r_;
  }
  PVector getLocation() {
    return new PVector(this.x, this.y);
  }
  void move() {
    if (dragged) {
      if (mousePressed) {
        x = mouseX;
        y = mouseY;
      } else {
        pmousePressed = nmousePressed;
        nmousePressed = mousePressed;
        dragged = false;
      }
    } else {
      pmousePressed = nmousePressed;
      nmousePressed = mousePressed;
      if (pmousePressed == false) {
        if (nmousePressed == true) {
          if (!(mouseX+r<x-r||mouseX-r>x+r)) {
            if (!(mouseY+r<y-r||mouseY-r>y+r)) {
              if ((mouseX-x)*(mouseX-x)+(mouseY-y)*(mouseY-y)<r*r) {
                x = mouseX;
                y = mouseY;
                dragged = true;
              }
            }
          }
        }
      }
    }
  }
  void show() {
    ellipse(x, y, r+r, r+r);
  }
}
