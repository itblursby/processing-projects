class Rectangle {
  float x1;
  float y1;
  float x2;
  float y2;
  color c = color(random(255), random(255), random(255));
  Rectangle(float x1_, float y1_, float x2_, float y2_) {
    this.x1 = x1_;
    this.y1 = y1_;
    this.x2 = x2_;
    this.y2 = y2_;
  }    
  float getWidth() {
    return abs(x2-x1);
  }
  float getHeight() {
    return abs(y2-y1);
  }
  void display() {
    rectMode(CORNERS);
    noStroke();
    fill(c);
    rect(x1, y1, x2, y2);
  }
  void set(float x1_, float y1_, float x2_, float y2_) {
    this.x1 = x1_;
    this.y1 = y1_;
    this.x2 = x2_;
    this.y2 = y2_;
  }
  void scale(float a) {
    this.x1 *= a;
    this.y1 *= a;
    this.x2 *= a;
    this.y2 *= a;
  }
  boolean onscreen() {
    if (max(x1, x2) < -width/2) {
      return false;
    }
    if (min(x1, x2) > width/2) {
      return false;
    }
    if (max(y1, y2) < -height/2) {
      return false;
    }
    if (min(y1, y2) > height/2) {
      return false;
    }
    return true;
  }
  String toString(){
    return "((" + x1 + "," + y1 + ")"+"(" + x2 + "," + y2 + "))";
  }
}
