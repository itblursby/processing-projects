class Cell {
  Set set;
  int x;
  int y;
  Cell(int x_, int y_) {
    set = new Set(-1);
    x = x_;
    y = y_;
  }
  public String toString() {
    return "(" + x + "," + y + ")";
  }
  void display() {
    noStroke();
    colorMode(HSB, 100);
    if (set.getIndex() == -1) {
      fill(0, 0, 0);
    } else {
      fill(0.61803*100*set.getIndex()%100, 100, 50);
    }
    square(x, y, cellsize);
  }
}
