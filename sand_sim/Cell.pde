class Cell {

  boolean state;

  boolean active;
  Cell(boolean state_, boolean active_) {
    this.state = state_; 
    //if false, means it is empty.
    //if true, means it is a sand particle.
    this.active = active_;

  }
}
