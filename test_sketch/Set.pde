/*
Used to store what set a cell is part of.
 For example, if a set is part of 
 */

class Set {
  private int ind = -1;
  Set() {
  }
  Set(int a){
    ind = a;
  }
  int setIndex(int a) {
    ind = a;
    return ind;
  }
  int getIndex() {
    return ind;
  }
  //boolean isEqual(Set other) {
  //  if (this.getIndex() == -1){
  //    return false;
  //  }
  //  if (other.getIndex() == -1){
  //    return false;
  //  }
  //  if (other.getIndex() == this.getIndex()){
  //    return true;
  //  }
  //  return false;
  //}
}
