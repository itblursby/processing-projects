class Cell {
  private color c; //color of cell
  private String name;
  private String rulestring;
  Cell(String name_, color c_, String rulestring_) {
    c = c_;
    name = name_;
    rulestring = rulestring_;
  }
  color col() {
    return c;
  }
  String name() {
    return name;
  }
  String rule() {
    return rulestring;
  }
}
class Line{
  
}
class TurnInto extends Line{
  TurnInto(String s){
  }
}
class Condition extends Line{
  Condition(String s){
  }
}
  
