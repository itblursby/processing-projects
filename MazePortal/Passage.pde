//a passage represents a link between two cells
class Passage {
  //true if the passage connects them, false otherwise
  private boolean unlocked;
  //cells that this passage directly connects
  Cell cellA;
  Cell cellB;
  Passage(Cell a_, Cell b_) {
    unlocked = false;
    cellA = a_;
    cellB = b_;
  }
  //Passage(boolean val){
  //  unlocked = val;
  //}
  boolean get() {
    //return random(1)>0.5;
    return unlocked;
  }
  public String toString() {
    return Boolean.toString(unlocked);
  }
  void unlock() {
    unlocked = true;
    cellA.join(cellB);
  }
  boolean sameSet(){
    return cellA.sameSet(cellB);
  }
}
