import java.util.Random;
import java.util.Collections;
final long seed = 112l;
Random rand = new Random(seed);
final int BIG_MAZE = 16;
final int SMALL_MAZE = 8;
final int CELL_SIZE = 10;
final int OFFSET = (BIG_MAZE - SMALL_MAZE)/2;
int[][] cells = new int[BIG_MAZE][BIG_MAZE];
//int[][] cells2 = new int[BIG_MAZE][BIG_MAZE];
boolean[][] hwalls = new boolean[BIG_MAZE][BIG_MAZE];
boolean[][] hwalls2 = new boolean[BIG_MAZE][BIG_MAZE];
boolean[][] vwalls = new boolean[BIG_MAZE][BIG_MAZE];
boolean[][] vwalls2 = new boolean[BIG_MAZE][BIG_MAZE];

//True is no wall present
//False is wall present
ArrayList<Integer> walls = new ArrayList<Integer>(BIG_MAZE*(BIG_MAZE-1)*2);
//even numbers are horizontal walls, odd numbers are vertical
//divide by two and then use the number to find the cells 
//and wall in the array
//every cell has the same indexes as the wall to the right and the wall below
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
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = 0; y < BIG_MAZE; y++) {
      cells[x][y] = x+y*BIG_MAZE;
    }
  }
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = 0; y < BIG_MAZE; y++) {
      hwalls[x][y] = false;
      if (y < BIG_MAZE-1) {
        walls.add((y*BIG_MAZE+x) * 2);
      }
      vwalls[x][y] = false;
      if (x < BIG_MAZE-1) {
        walls.add((y*BIG_MAZE+x) * 2+1 );
      }
    }
  }
  //print(walls.size());
  Collections.shuffle(walls, rand);
  for (int i = 0; i < walls.size(); i++) {
    int x = getX(walls.get(i));
    int y = getY(walls.get(i));
    if ((walls.get(i) & 1) == 0) {
      if (!sameSet(x, y, x, y+1)) {
        hwalls[getX(walls.get(i))][getY(walls.get(i))] = true;
        join(x, y, x, y+1);
      }
    } else {
      if (!sameSet(x, y, x+1, y)) {
        vwalls[getX(walls.get(i))][getY(walls.get(i))] = true;
        join(x, y, x+1, y);
      }
    }
  }
  walls.clear();
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = 0; y < OFFSET; y++) {
      walls.add((x+y*BIG_MAZE)*2);
      if (x < BIG_MAZE-1) {
        walls.add((x+y*BIG_MAZE)*2+1);
      }
    }
  }
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = OFFSET+SMALL_MAZE; y < BIG_MAZE; y++) {
      if (y < BIG_MAZE-1) {
        walls.add((x+y*BIG_MAZE)*2);
      }
      if (x < BIG_MAZE-1) {
        walls.add((x+y*BIG_MAZE)*2+1);
      }
    }
  }
  for (int x = 0; x < OFFSET; x++) {
    for (int y = OFFSET; y < OFFSET+SMALL_MAZE; y++) {
      walls.add((x+y*BIG_MAZE)*2);
      walls.add((x+y*BIG_MAZE)*2+1);
    }
  }
  for (int x = OFFSET+SMALL_MAZE; x < BIG_MAZE; x++) {
    for (int y = OFFSET; y < OFFSET+SMALL_MAZE; y++) {
      walls.add((x+y*BIG_MAZE)*2);
      if (x < BIG_MAZE-1) {
        walls.add((x+y*BIG_MAZE)*2+1);
      }
    }
  }
  print(OFFSET);
  size(600, 600);
  noFill();
}
int xoff = 100;
int yoff = 100;
void draw() {

  //background(255);
  //move(Direction.DOWN);
  display();
}
void keyPressed() {
  if (key == CODED) {
    if (keyCode == RIGHT) {
      move(Direction.LEFT);
      xoff+=CELL_SIZE;
    }
    if (keyCode == LEFT) {
      move(Direction.RIGHT);
      xoff-=CELL_SIZE;
    }
    if (keyCode == UP) {
      move(Direction.DOWN);
      yoff-=CELL_SIZE;
    }
    if (keyCode == DOWN) {
      move(Direction.UP);
      yoff+=CELL_SIZE;
    }
  }
}
void displaybig() {
  translate(xoff, yoff);
  noStroke();
  fill(200, 200, 255);
  square(OFFSET*CELL_SIZE, OFFSET*CELL_SIZE, SMALL_MAZE*CELL_SIZE);
  stroke(0);
  noFill();
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = 0; y < BIG_MAZE-1; y++) {
      if (!hwalls[x][y]) {
        line(x*CELL_SIZE, y*CELL_SIZE+CELL_SIZE, x * CELL_SIZE+CELL_SIZE, y*CELL_SIZE+CELL_SIZE);
      }
    }
  }
  for (int x = 0; x < BIG_MAZE-1; x++) {
    for (int y = 0; y < BIG_MAZE; y++) {
      if (!vwalls[x][y]) {
        line(x*CELL_SIZE+CELL_SIZE, y*CELL_SIZE, x * CELL_SIZE+CELL_SIZE, y*CELL_SIZE+CELL_SIZE);
      }
    }
  }
}
void display() {
  translate(xoff, yoff);
  for (int x = 0; x < SMALL_MAZE; x++) {
    for (int y = 0; y < SMALL_MAZE; y++) {
      if (!hwalls[x+OFFSET][y+OFFSET]) {
        line(x*CELL_SIZE, y*CELL_SIZE+CELL_SIZE, x * CELL_SIZE+CELL_SIZE, y*CELL_SIZE+CELL_SIZE);
      }
      if (!vwalls[x+OFFSET][y+OFFSET]) {
        line(x*CELL_SIZE+CELL_SIZE, y*CELL_SIZE, x * CELL_SIZE+CELL_SIZE, y*CELL_SIZE+CELL_SIZE);
      }
    }
  }
}
int getX(int a) {
  return (a >> 1)%BIG_MAZE;
}
int getY(int a) {
  return (a >> 1)/BIG_MAZE;
}
int getRoot(int x, int y) {
  if (cells[x][y] == x+y*BIG_MAZE) {
    return cells[x][y];
  } else {
    int result = getRoot(cells[x][y]%BIG_MAZE, cells[x][y]/BIG_MAZE);
    cells[x][y] = result;
    return result;
  }
}
void join(int x1, int y1, int x2, int y2) {
  int r1 = getRoot(x1, y1);
  cells[r1%BIG_MAZE][r1/BIG_MAZE] = x2 + y2*BIG_MAZE;
}
boolean sameSet(int x1, int y1, int x2, int y2) {
  return getRoot(x1, y1) == getRoot(x2, y2);
}
void move(Direction d) {

  for (int x = OFFSET; x < SMALL_MAZE+OFFSET; x++) {
    for (int y = OFFSET; y < SMALL_MAZE+OFFSET; y++) {
      hwalls2[x][y] = hwalls[(x-d.x)][(y-d.y)]; 
      vwalls2[x][y] = vwalls[(x-d.x)][(y-d.y)];
    }
  }
  Collections.shuffle(walls, rand);
  for (int x = 0; x < BIG_MAZE; x++) {
    for (int y = 0; y < BIG_MAZE; y++) {
      cells[x][y] = x+y*BIG_MAZE;
      hwalls[x][y] = false;
      vwalls[x][y] = false;
    }
  }
  for (int x = OFFSET; x < SMALL_MAZE+OFFSET; x++) {
    for (int y = OFFSET; y < SMALL_MAZE+OFFSET; y++) {
      if (hwalls2[x][y]&&!sameSet(x, y, x, y+1)) {
        join(x, y, x, y+1);
      }
      if (vwalls2[x][y]&&!sameSet(x, y, x+1, y)) {
        join(x, y, x+1, y);
      }
    }
  }
  for (int i = 0; i < walls.size(); i++) {
    int x = getX(walls.get(i));
    int y = getY(walls.get(i));
    if ((walls.get(i) & 1) == 0) {
      if (!sameSet(x, y, x, y+1)) {
        hwalls2[getX(walls.get(i))][getY(walls.get(i))] = true;
        join(x, y, x, y+1);
      }
    } else if (!sameSet(x, y, x+1, y)) {
      vwalls2[getX(walls.get(i))][getY(walls.get(i))] = true;
      join(x, y, x+1, y);
    }
  }
  boolean[][] temp;
  temp = hwalls;
  hwalls = hwalls2;
  hwalls2 = temp;
  temp = vwalls;
  vwalls = vwalls2;
  vwalls2 = temp;
}
//void reset() {
//  for (int x = 0; x < BIG_MAZE; x++) {
//    for (int y = 0; y < BIG_MAZE; y++) {
//      cells[x][y] = x+y*BIG_MAZE;
//      hwalls[x][y] = false;
//      vwalls[x][y] = false;
//    }
//  }
//}
