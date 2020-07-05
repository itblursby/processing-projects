class Cell {
  private Cell parent;  
  private color col; //for debugging  
  int x;
  int y;
  Cell(int x_, int y_) { 
    x = x_;
    y = y_;
    parent = this;
    colorMode(HSB, 100);
    col = color(random(0, 100), 100, 100);
  }
  //gets the set color *USED FOR DEBUGGING*
  color getColor() {
    if (parent == this) {
      return col;
    }
    return getRoot().getColor();
  }
  //sets a cell's parent and returns the parent.
  Cell setParent(Cell c) {
    this.parent = c;
    return c;
  }

  //returns the root representative of a cell.
  //if the cell's root is not its direct parent,
  //it will set the parent to its root. 
  Cell getRoot() {
    if (parent == this) {
      return this;
    } else {
      Cell result = parent.getRoot();
      parent = result;
      return result;
    }
  }
  //joins two sets.
  void join(Cell c) {
    this.getRoot().setParent(c);
  }
  //returns true if cells are part of the same set
  //i.e. have the same root representative.
  //returns false otherwise.
  boolean sameSet(Cell c) {
    if (this.getRoot() == c.getRoot()) {
      return true;
    }
    return false;
  }
  void display() {

    noStroke();
    fill(getColor());
    //colorMode(RGB,255);
    //fill(0);
    square(x*cellsize, y*cellsize, cellsize);
  }
}
