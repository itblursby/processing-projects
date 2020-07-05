class Wall {
  Cell c1;
  Cell c2;
  boolean vertical;
  Wall(Cell c1_, Cell c2_) {
    c1 = c1_;
    c2 = c2_;
    if (c1.x == c2.x) {
      vertical = false;
    } else {
      vertical = true;
    }
  }
  void display() {
    colorMode(RGB, 255, 255, 255);
    strokeWeight(1);
    stroke(255);
    if (vertical) {
      line(c2.x,c2.y,c2.x,c2.y+cellsize);
    }else{
      line(c2.x,c2.y,c2.x+cellsize,c2.y);
    }
  }
  public String toString(){
    return "wall dividing " + c1.toString() + " and " + c2.toString();
  }
}
