//a passage represents a link between two cells
class Passage {
  //true if the passage connects them, false otherwise
  private boolean unlocked;
  //cells that this passage directly connects
  Cell cellA;
  Cell cellB;
  Passage(boolean val_, Cell a_, Cell b_) {
    unlocked = val_;
    cellA = a_;
    cellB = b_;
  }
  //Passage(boolean val){
  //  unlocked = val;
  //}
  boolean get() {
    return unlocked;
  }
  void set(boolean v) {
    unlocked = v;
  }
  public String toString() {
    return Boolean.toString(unlocked);
  }
  void unlock() {
    unlocked = true;
    cellA.join(cellB);
  }
}
