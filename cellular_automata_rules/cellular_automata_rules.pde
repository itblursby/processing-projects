
/*
rulestrings
 T(cell) turn into cell
 //MTN(cell1, cell2) move to neighboring cell1, leave cell2
 //MTA(cell1, cell2) move to any cell1, leave cell2
 I(cell,Compare,value){}
 */
enum Cells{
  alive, dead
}
HashMap<String,Cell> cells = new HashMap<String,Cell>();
cells.put("alive", new Cell("alive",color(255),"I(dead,

enum Compare{
  less,equal,greater,lessequal,greaterequal
}
void setup() {
}
void draw() {
}
