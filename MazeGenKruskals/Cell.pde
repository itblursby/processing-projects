class Cell {
  private Cell parent;
  //basically boolean variables that will hold true
  //if this cell is directly connected to the cell
  //in a given direction
  Passage right;
  Passage left; 
  Passage up;
  Passage down;
  int x;
  int y;
  int distance;
  //used for pathfinding
  Cell pre;
  int cost;
  Cell(int x_, int y_) { 
    parent = this;
    x = x_;
    y = y_;
    //right = new Passage(false);
    //left = new Passage(false);
    //up = new Passage(false);
    //down = new Passage(false);
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
  void setPre(Cell other) {
    pre = other;
    cost = other.cost + 1;
  }
  int getCost() {
    return cost+this.getDistance();
  }
  int getDistance() {
    return goalx-this.x+goaly-this.y;
  }
}
