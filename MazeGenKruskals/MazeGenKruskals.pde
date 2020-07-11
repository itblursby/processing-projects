import java.util.Collections;
import java.util.Random;

final long seed = 2l;
final int cellsize = 10;
final int mw = 30;
final int mh = 30;
final int wallsize = 1;

final int beginx = 0;
final int beginy = mh-1;
final int goalx = mw-1;
final int goaly = 0;

final int speed = 100;
final boolean save = false;

Random rand = new Random(seed);
Cell[][] maze = new Cell[mw][mh];

ArrayList<Passage> passages = new ArrayList<Passage>((mw)*(mh-1)+(mw-1)*(mh));
ArrayList<Cell> stack = new ArrayList<Cell>(100);
//0 for generating maze state
//1 for solving state
//2 for done
int phase = 0;
void setup() {
  size(700, 700);
  for (int x = 0; x < mw; x++) {
    for (int y = 0; y < mh; y++) {
      maze[x][y] = new Cell(x, y);
    }
  }
  for (int x = 0; x < mw; x++) {
    for (int y = 0; y < mh; y++) {
      if (x < mw-1) {
        maze[x][y].right = new Passage(false, maze[x][y], maze[x+1][y]);
        maze[x+1][y].left = maze[x][y].right;
        passages.add(maze[x][y].right);
        //maze[x][y].right.unlock();
      }
      if (y < mh-1) {
        maze[x][y].down = new Passage(false, maze[x][y], maze[x][y+1]);
        maze[x][y+1].up = maze[x][y].down;
        passages.add(maze[x][y].down);
      }
    }
  }
  //initializes stack for pathfinding
  stack.add(maze[beginx][beginy]);
  maze[beginx][beginy].cost = 0;
  maze[beginx][beginy].pre = maze[beginx][beginy];
  Collections.shuffle(passages, rand);
}
int counter = 0;
void draw() {
  if (phase == 0) {
    for (int i = 0; i < speed; i++) {
      if (counter < passages.size()) {
        if (!passages.get(counter).cellA.sameSet(passages.get(counter).cellB)) {
          passages.get(counter).unlock();
        }
        counter++;
      } else {
        break;
      }
    }
    background(255);
    display();
    if (counter == passages.size()) {
      if (save) {
        saveFrame("maze"+"w"+mw+"h"+mw+"s"+seed);
      }
      phase = 1;
      println("1");
    }
  } else if (phase == 1) {
    for (int b = 0; b < speed; b++) {
      Cell current = stack.get(0);
      int tempindex = 0;
      for (int i = 0; i < stack.size(); i++) {
        if (current.getCost() > stack.get(i).getCost()) {
          current = stack.get(i);
          tempindex = i;
        }
      }

      if (current.right!=null&&current.right.get()) {
        if (maze[current.x+1][current.y].pre == null) {
          maze[current.x+1][current.y].pre = current;
          maze[current.x+1][current.y].cost = current.cost + 1;
          stack.add(maze[current.x+1][current.y]);
          if (current.x+1 == goalx) {
            if (current.y == goaly) {
              phase = 2;
              println("2");
              break;
            }
          }
        }
      }
      if (current.left!=null&&current.left.get()) {
        if (maze[current.x-1][current.y].pre == null) {
          maze[current.x-1][current.y].pre = current;
          maze[current.x-1][current.y].cost = current.cost + 1;
          stack.add(maze[current.x-1][current.y]);
          if (current.x-1 == goalx) {
            if (current.y == goaly) {
              phase = 2;
              println("2");
              break;
            }
          }
        }
      }
      if (current.up!=null&&current.up.get()) {
        if (maze[current.x][current.y-1].pre == null) {
          maze[current.x][current.y-1].pre = current;
          maze[current.x][current.y-1].cost = current.cost + 1;
          stack.add(maze[current.x][current.y-1]);
          if (current.x == goalx) {
            if (current.y-1 == goaly) {
              phase = 2;
              println("2");
              break;
            }
          }
        }
      }
      if (current.down!=null&&current.down.get()) {
        if (maze[current.x][current.y+1].pre == null) {
          maze[current.x][current.y+1].pre = current;
          maze[current.x][current.y+1].cost = current.cost + 1;
          stack.add(maze[current.x][current.y+1]);
          if (current.x == goalx) {
            if (current.y+1 == goaly) {
              phase = 2;
              println("2");
              break;
            }
          }
        }
      }
      stack.remove(tempindex);
      //if (stack.size() == 0) {
      //  phase = 2;
      //  println("2");
      //  break;
      //}
    }
    background(255);
    display();
    //if (phase == 2){
    //  if (save){
    //    saveFrame("pretty.png");
    //  }
    //}
  } else if (phase == 2) {
    background(255);
    end();
    noLoop();
    println("done");
    if (save) {
      saveFrame("solu"+"w"+mw+"h"+mw+"s"+seed);
    }
  }
}
void display() {

  translate((width-(mw*cellsize))/2, (height-(mh*cellsize))/2);
  noStroke();
  //for (int x = 0; x < mw; x++) {
  //  for (int y = 0; y < mh; y++) {
  //    //noFill();
  //    fill(maze[x][y].cost*10);
  //    square(maze[x][y].x*cellsize,maze[x][y].y*cellsize,cellsize);
  //  }
  //}
  strokeWeight(wallsize);
  noFill();
  for (int x = 0; x < mw; x++) {
    for (int y = 0; y < mh; y++) {
      colorMode(RGB, 255);
      stroke(0);
      if (maze[x][y].right != null&&!maze[x][y].right.get()) {
        line(x*cellsize+cellsize, y*cellsize, x*cellsize+cellsize, y*cellsize+cellsize);
      }
      if (maze[x][y].down != null&&!maze[x][y].down.get()) {
        line(x*cellsize, y*cellsize+cellsize, x*cellsize+cellsize, y*cellsize+cellsize);
      }
      //stroke(255, 0, 0);
      if (phase == 1) {
        if (maze[x][y].pre != null) {


          stroke(255, 0, 0);
          line(maze[x][y].x*cellsize+cellsize/2, maze[x][y].y*cellsize+cellsize/2, maze[x][y].pre.x*cellsize+cellsize/2, maze[x][y].pre.y*cellsize+cellsize/2);
        }
      }
    }
  }
  noFill();
  colorMode(RGB, 255);
  stroke(0);
  rect(0, 0, mw*cellsize, mh*cellsize);
}
void end() {
  colorMode(RGB, 255);
  translate((width-(mw*cellsize))/2, (height-(mh*cellsize))/2);
  strokeWeight(wallsize);
  noFill();
  stroke(0);
  for (int x = 0; x < mw; x++) {
    for (int y = 0; y < mh; y++) {
      if (maze[x][y].right != null&&!maze[x][y].right.get()) {
        line(x*cellsize+cellsize, y*cellsize, x*cellsize+cellsize, y*cellsize+cellsize);
      }
      if (maze[x][y].down != null&&!maze[x][y].down.get()) {
        line(x*cellsize, y*cellsize+cellsize, x*cellsize+cellsize, y*cellsize+cellsize);
      }
    }
  }
  rect(0, 0, mw*cellsize, mh*cellsize);
  stroke(255, 0, 0);
  Cell current = maze[goalx][goaly];
  while (current.pre != current) {
    line(current.x*cellsize+cellsize/2, current.y*cellsize+cellsize/2, current.pre.x*cellsize+cellsize/2, current.pre.y*cellsize+cellsize/2);
    current = current.pre;
  }
  println("happy");
}
