public class DragCircle {
  float x = 0;
  float y = 0;
  float r = 1;
  private static boolean pMousePressed = true;
  private static boolean nMousePressed = true;
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
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  void move() {
    if (dragged) {
      if (nMousePressed) {
        x = mouseX;
        y = mouseY;
      }
    } else {
      if (!pMousePressed && nMousePressed) {
        if ((mouseX-x)*(mouseX-x)+(mouseY-y)*(mouseY-y)<r*r) {
          x = mouseX;
          y = mouseY;
          dragged = true;
        }
      }
    }
  }
  void display() {
    ellipse(x, y, r+r, r+r);
  }
  
}
