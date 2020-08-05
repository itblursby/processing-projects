class Passage {
  boolean passable;
  boolean previous;
  Cell A;
  Cell B;
  Passage(Cell A_, Cell B_) {
    passable = false;
    A = A_;
    B = B_;
  }
  void unlock(){
    passable = true;
    A.join(B);
  }
  public String toString() {
    return Boolean.toString(passable);
  }
  
}
