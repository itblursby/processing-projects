class Cell {
  //true if cell has access to another cell in a given direction.
  //directions[0] is whether the cell is connected to the cell to the right of it
  //directions[1] is whether the cell is connected to the cell below it;
  boolean[] directions = new boolean[2];
  int x;
  int y;
  boolean visited;
  Cell(int x_, int y_) {
    x = x_;
    y = y_;
    directions[0] = false;
    directions[1] = false;
    visited = false;
  }
  
}
