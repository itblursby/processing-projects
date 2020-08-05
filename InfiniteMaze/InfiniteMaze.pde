import java.util.Random;
import java.util.Collections;

final long seed = 112l;
Random rand = new Random(seed);

//width and height of maze that is generated
final int BIG_MAZE = 10;
//width and height of maze that is actually rendered/visable.
final int SMALL_MAZE = 6;
final int CELL_SIZE = 20;

final int OFFSET = (BIG_MAZE - SMALL_MAZE)/2;

Cell[][] maze = new Cell[BIG_MAZE][BIG_MAZE];

ArrayList<Passage> passages = new ArrayList<Passage>(2*(BIG_MAZE*BIG_MAZE-BIG_MAZE));

enum Direction {
  DOWN(0, 1), UP(0, -1), LEFT(-1, 0), RIGHT(1, 0);
  final int x;
  final int y;
  private Direction(int x_, int y_) {
    x = x_;
    y = y_;
  }
}
void setup() {
  frameRate(10);
  size(600, 600);
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = 0; y < BIG_MAZE; y++) {
      maze[x][y] = new Cell();
    }
  }
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = 0; y < BIG_MAZE; y++) {
      if (x < BIG_MAZE-1) {
        maze[x][y].right = new Passage(maze[x][y], maze[x+1][y]);
        maze[x+1][y].left = maze[x][y].right;
        passages.add(maze[x][y].right);
      }
      if (y < BIG_MAZE-1) {
        maze[x][y].down = new Passage(maze[x][y], maze[x][y+1]);
        maze[x][y+1].up = maze[x][y].down;
        passages.add(maze[x][y].down);
      }
    }
  }
  Collections.shuffle(passages, rand);
  for (int i = 0; i < passages.size(); i++) {
    if (!passages.get(i).A.sameSet(passages.get(i).B)) {
      passages.get(i).unlock();
    }
  }
}

void draw() {
  background(255);
  display();
}
void display() {
  translate(10, 10);
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = 0; y < BIG_MAZE; y++) {
      if (x < BIG_MAZE-1 && !maze[x][y].right.passable) {
        line(x*CELL_SIZE+CELL_SIZE, y*CELL_SIZE, x*CELL_SIZE+CELL_SIZE, y*CELL_SIZE+CELL_SIZE);
      }
      if (y < BIG_MAZE-1 && !maze[x][y].down.passable) {
        line(x*CELL_SIZE, y*CELL_SIZE+CELL_SIZE, x*CELL_SIZE+CELL_SIZE, y*CELL_SIZE+CELL_SIZE);
      }
    }
  }
}
void move(Direction d){
  
}
