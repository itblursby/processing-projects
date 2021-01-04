import java.util.LinkedList;
import java.io.PrintWriter;
import java.io.File;

final int MAZE_WIDTH = 150;
final int MAZE_LENGTH = 150;
final int CELL_SIZE = 2;
final int STRAIGHT_MAX = 2;
final long seed = 248;
boolean done = false;
int[][] maze = new int[MAZE_WIDTH][MAZE_LENGTH];
//-1 is a wall
//all other values denote the group it is part of,
//meaning all cells that connect to it have the same group
LinkedList<Integer> stack = new LinkedList();
int[] adj = new int[4];
int[] biasArr = new int[4];
int bias = -1;
int nextstep;
int biasedCount = 0; //records how many times gone in a straight line.
// 0
//3#1
// 2
//set -1 for no bias
void setup() {
  noStroke();
  randomSeed(seed);
  bias = (int)random(4);
  for (int x = 0; x < MAZE_WIDTH; x++) {
    for (int y = 0; y < MAZE_LENGTH; y++) {
      maze[x][y] = -1;
    }
  }
  int begin = (int)random(MAZE_WIDTH*MAZE_LENGTH);
  maze[getX(begin)][getY(begin)] = 0;
  stack.push(begin);

  size(400, 400);
}
void draw() {
  translate(5, 5);
  background(255);
  fill(0);

  rect(0, 0, (MAZE_WIDTH+2)*CELL_SIZE, (MAZE_LENGTH+2)*CELL_SIZE);
  //
  noStroke();

  translate(CELL_SIZE, CELL_SIZE);
  for (int i = 0; i < 25 && !done; i++) {
    iterate();
  }


  display();
}
int getIndex(int x, int y) {
  return y*MAZE_WIDTH+x;
}
int getX(int i) {
  return i % MAZE_WIDTH;
}
int getY(int i) {
  return i / MAZE_WIDTH;
}
void display() {
  for (int x = 0; x < MAZE_WIDTH; x++) {
    for (int y = 0; y < MAZE_LENGTH; y++) {
      if (maze[x][y] == -1) {
        fill(0);
        //print("bruh");
      } else {
        fill(255);
      }
      //fill(0);
      rect(x*CELL_SIZE, y*CELL_SIZE, CELL_SIZE, CELL_SIZE);
    }
  }
}
void iterate() {
  if (stack.size() == 0) {
    noLoop();
    done = true;
  } else {
    int current = stack.peek();
    int x = getX(current);
    int y = getY(current);
    int size = 0;
    //boolean biased = false;
    nextstep = -1;
    if (removeable(x+1, y)) {
      adj[size] = current + 1;
      biasArr[size] = 1;
      size++;
      if (bias == 1) {
        nextstep = current + 1;
      }
    }
    if (removeable(x-1, y)) {
      adj[size] = current - 1;
      biasArr[size] = 3;
      size++;
      if (bias == 3) {
        nextstep = current - 1;
      }
    }
    if (removeable(x, y+1)) {
      adj[size] = current + MAZE_WIDTH;
      biasArr[size] = 2;
      size++;
      if (bias == 2) {
        nextstep = current + MAZE_WIDTH;
      }
    }
    if (removeable(x, y-1)) {
      adj[size] = current - MAZE_WIDTH;
      biasArr[size] = 0;
      size++;
      if (bias == 0) {
        nextstep = current - MAZE_WIDTH;
      }
    }
    if (nextstep == -1) {
      if (size == 0) {
        stack.pop();
      } else {
        int randomNum = (int)random(size);
        int i = adj[randomNum];
        maze[getX(i)][getY(i)] = 0;
        stack.push(i);
        bias = biasArr[randomNum];
      }
    } else {
      biasedCount++;
      maze[getX(nextstep)][getY(nextstep)] = 0;
      stack.push(nextstep);
      if (biasedCount > STRAIGHT_MAX) {
        int newbias = (int)random(3);
        if (newbias >= bias) newbias += 1;
        bias = newbias;
        biasedCount = 0;
      }
    }
  }
}
boolean removeable(int x, int y) {
  short a = 0;
  if (x >= MAZE_WIDTH || x < 0) return false;
  if (y >= MAZE_LENGTH || y < 0) return false;
  if (maze[x][y] != -1) return false;
  if (x+1 < MAZE_WIDTH && maze[x+1][y] != -1) a++;
  if (x-1 >= 0 && maze[x-1][y] != -1) a++;
  if (y+1 < MAZE_LENGTH && maze[x][y+1] != -1) a++;
  if (y-1 >= 0 && maze[x][y-1] != -1) a++;
  return (a < 2);
}
