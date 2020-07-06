class Wall {
  //Cells that this wall divides.
  private Cell a;
  private Cell b;
  //private boolean active;
  private boolean vertical;
  Wall(Cell a_, Cell b_) {
    a = a_;
    b = b_;
    if (a.x == b.x) {
      vertical = false;
    } else {
      vertical = true;
    }
  }
  //removes this wall if the cells are part of different sets and joins the two cells.
  //returns true if wall remains and false if wall has been removed.
  boolean removable() {
    if (a.sameSet(b)) {
      return false;
    }
    return true;
  }
  void join(){
    a.join(b);
  }
  //boolean isActive() {
  //  return active;
  //}
  void display() {
    stroke(0);
    strokeWeight(wallsize);
    if (vertical) {
      line(b.x*cellsize, b.y*cellsize, b.x*cellsize, b.y*cellsize+cellsize);
    } else {
      line(b.x*cellsize, b.y*cellsize, b.x*cellsize+cellsize, b.y*cellsize);
    }
  }
}
