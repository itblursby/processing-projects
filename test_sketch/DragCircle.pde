class DragCircle {
  float x = 0;
  float y = 0;
  float r = 10;
  float inf = 50;
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
