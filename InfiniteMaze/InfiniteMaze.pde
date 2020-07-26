import java.util.Random;
import java.util.Collections;

final long seed = 112l;
Random rand = new Random(seed);

//width and height of maze that is generated
final int BIG_MAZE = 10;
//width and height of maze that is actually rendered/visable.
final int SMALL_MAZE = 6;
//array of cells
Cell[][] maze = new Cell[BIG_MAZE][BIG_MAZE];
//enumerates directions
ArrayList<Passage> passages = new ArrayList<Passage>(2*(BIG_MAZE*BIG_MAZE-BIG_MAZE));
enum Dir {
  DOWN(0, 1), UP(0, -1), LEFT(-1, 0), RIGHT(1, 0);
  final int x;
  final int y;
  private Dir(int x_, int y_) {
    x = x_;
    y = y_;
  }
}
void setup() {
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = 0; y < BIG_MAZE; y++) {
      maze[x][y] = new Cell();
    }
  }
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = 0; y < BIG_MAZE; y++) {
      if (x < BIG_MAZE-1) {
        maze[x][y].right = new Passage(maze[x][y],maze[x+1][y]);
        maze[x+1][y].left = maze[x][y].right;
        passages.add(maze[x][y].right);
      }
      if (y < BIG_MAZE-1){
        maze[x][y].down = new Passage(maze[x][y],maze[x][y+1]);
        maze[x][y+1].up = maze[x][y].down;
        passages.add(maze[x][y].right);
      }
    }
  }
}
void draw() {
}
