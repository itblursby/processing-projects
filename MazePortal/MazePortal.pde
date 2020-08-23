import java.util.Collections;
import java.util.Random;
final int MAZE_WIDTH = 10;
final int MAZE_HEIGHT = 10;
final int CELL_SIZE = 10;
final float PORTAL_AMOUNT = 0.5;
final long seed = 391;
Random rand = new Random(seed);

Cell[][] maze = new Cell[MAZE_WIDTH][MAZE_HEIGHT];
ArrayList<Passage> walls = new ArrayList<Passage>(2*MAZE_WIDTH*MAZE_HEIGHT);
ArrayList<Cell> celllist = new ArrayList<Cell>(MAZE_WIDTH*MAZE_HEIGHT);

void setup() {
  pixelDensity(displayDensity());
  size(600,600);
  for (int x = 0; x < MAZE_WIDTH; x++) {
    for (int y = 0; y < MAZE_HEIGHT; y++) {
      maze[x][y] = new Cell();
      celllist.add(maze[x][y]);
    }
  }
  for (int x = 0; x < MAZE_WIDTH; x++) {
    for (int y = 0; y < MAZE_HEIGHT; y++) {
      if (x < MAZE_WIDTH-1) {
        maze[x][y].right = new Passage(maze[x][y], maze[x+1][y]);
        maze[x+1][y].left = maze[x][y].right;
        walls.add(maze[x][y].right);
      }
      if (y < MAZE_HEIGHT-1) {
        maze[x][y].down = new Passage(maze[x][y], maze[x][y+1]);
        maze[x][y+1].up = maze[x][y].down;
        walls.add(maze[x][y].down);
      }
    }
  }
  println(walls.size());
  Collections.shuffle(walls,rand);
  for (int i = 0; i < walls.size(); i++) {
    Passage p = walls.get(i);
    if (!p.sameSet()) {
      p.unlock();
      //println(true);
    }
  }
  textSize(8);
}
void draw() {
  background(255);
  display();
}

void display() {
  textAlign(CENTER,CENTER);
  //fill(0);
  noFill();
  translate(10,10);
  rect(0,0,MAZE_WIDTH*CELL_SIZE,MAZE_HEIGHT*CELL_SIZE);
  stroke(0);
  fill(0);
  for (int x = 0; x < MAZE_WIDTH; x++) {
    for (int y = 0; y < MAZE_HEIGHT; y++) {
      text("99",x*CELL_SIZE+(CELL_SIZE >> 1),y*CELL_SIZE+(CELL_SIZE >> 1));
      if (maze[x][y].right != null&&!maze[x][y].right.get()) {
        line(x*CELL_SIZE+CELL_SIZE, y*CELL_SIZE, x*CELL_SIZE+CELL_SIZE, y*CELL_SIZE+CELL_SIZE);
      }
      if (maze[x][y].down != null&&!maze[x][y].down.get()) {
        line(x*CELL_SIZE, y*CELL_SIZE+CELL_SIZE, x*CELL_SIZE+CELL_SIZE, y*CELL_SIZE+CELL_SIZE);
      }
    }
  }
}
