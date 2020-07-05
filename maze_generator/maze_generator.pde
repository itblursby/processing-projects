/*
Uses randomized Kruskal's algorithm
 */
import java.util.Collections;

//width and length of cell in pixels
int cellsize = 10; 
//maze width
int mw = 40; 
//maze height
int mh = 40; 

//2D array with cells
Cell[][] cells = new Cell[mw][mh]; 
//arraylist with walls so I can iterate through
ArrayList<Wall> walls = new ArrayList<Wall>(0); 

//used by Set to determine the next index to use to avoid duplicates
int nextindex = 0; 

void setup() {
  size(600, 600);
  background(255);
  //frameRate(60);
  //initializing cells
  for (int x = 0; x < mw; x++) { 
    for (int y = 0; y < mw; y++) {
      cells[x][y] = new Cell(x * cellsize, y * cellsize);
    }
  }
  //initializing walls
  for (int x = 0; x < mw; x++) { 
    for (int y = 0; y < mh; y++) {
      if (x < mw-1) {
        walls.add(new Wall(cells[x][y], cells[x+1][y]));
      }
      if (y < mh-1) {
        walls.add(new Wall(cells[x][y], cells[x][y+1]));
      }
    }
  }
  Collections.shuffle(walls);
  //print(walls.size());
  //for (int i = 0; i < walls.size(); i++) {
  //  //println(walls.get(i));
  //  walls.get(i).display();
  //}
}
int a = 0;
void draw() {
  //int a=0;
  //for (int j = 0; j < 100&&a < walls.size(); j++) {
  Wall current = walls.get(a); 
  int index1 = current.c1.set.getIndex();
  int index2 = current.c2.set.getIndex();
  //-1 is the "empty" value for a set. This means the cell is a singular cell with walls on each side.
  if (index1 == -1 && index2 == -1) { //case if both cells are -1
    current.c1.set.setIndex(nextindex); 
    current.c2.set = current.c1.set; 
    walls.remove(a); 
    nextindex++; 
    //println(nextindex);
  } else if (index1 == -1&&index2 != -1) { //case if cell1 is -1 and cell2 is not -1
    current.c1.set = current.c2.set; 

    walls.remove(a);
  } else if (index1 != -1&&index2 == -1) { //case if cell1 is not -1 and cell2 is -1
    current.c2.set = current.c1.set; 
    println(current.c2.set == current.c1.set);
    walls.remove(a);
  } else if (index1 != index2) {
    //current.c2.set = current.c1.set; 
    current.c2.set.setIndex(current.c1.set.getIndex());
    //print(current.c2.set.equals(current.c1.set));
    walls.remove(a); 
    //nextindex++;
  } else {
    a++;
  }

  background(255);
  for (int x = 0; x < mw; x++) {
    for (int y = 0; y < mh; y++) {
      cells[x][y].display();
    }
  }
  for (int i = 0; i < walls.size(); i++) {
    //println(walls.get(i));
    walls.get(i).display();
  }
  //a++;
  if (a >= walls.size()) {
    noLoop(); 
    saveFrame(); 
    println("done");
  }
}
