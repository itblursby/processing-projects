class Cell {
  Cell parent = this;
  Passage right;
  Passage left;
  Passage up;
  Passage down;
  Cell() {
  }
  Cell getRoot() {
    if (parent == this) {
      return this;
    } else {
      Cell result = parent.getRoot();
      parent = result;
      return result;
    }
  }
  void join(Cell other) {
    this.getRoot().parent = other;
  }
  boolean sameSet(Cell c) {
    return this.getRoot() == c.getRoot();
  }
}
