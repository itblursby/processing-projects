import java.util.Collections;

final int cellsize = 6;
final int mw = 100;
final int mh = 100;

final int wallsize = 1;
final int wallcount = mw*(mh-1)+mh*(mw-1);

Cell[] cells = new Cell[mw*mh];
ArrayList<Wall> walls = new ArrayList<Wall>(0);


void setup() {

  for (int x = 0; x < mw; x++) {
    for (int y = 0; y < mh; y++) {
      cells[x+y*mw] = new Cell(x, y);
    }
  }
  for (int x = 0; x < mw; x++) {
    for (int y = 0; y < mh; y++) {
      if (x < mw-1) {
        walls.add(new Wall(cells[x+y*mw], cells[x+1+y*mw]));
      }
      if (y < mh-1) {
        walls.add(new Wall(cells[x+y*mw], cells[x+(y+1)*mw]));
      }
    }
  }
  Collections.shuffle(walls);
  size(600, 600);
  colorMode(RGB, 255);
}
int a = 0;
void draw() {
  for (int i = 0; i < 100; i++) {
    if (a < walls.size()) {
      if (walls.get(a).removable()) {
        walls.get(a).join();
        walls.remove(a);
      } else {
        a++;
      }
    } else {
      break;
    }
  }
  background(255);
  display();
  if (a >= walls.size()) {
    noLoop();
    background(255);
    for (int i = 0; i < walls.size(); i++) {
      walls.get(i).display();
    }
    border();
    saveFrame("maze.png");
  }
}
void display() {
  
  for (int i = 0; i < cells.length; i++) {
    cells[i].display();
    //color col = cells[i].getColor();
    //noStroke();
    //fill(col);
    //square((i%mw)*cellsize, (i/mw)*cellsize, cellsize);
  }
  for (int i = 0; i < walls.size(); i++) {
    walls.get(i).display();
  }
  noFill();
}
void border(){  rect(0,0,mw*cellsize,mh*cellsize);

}
