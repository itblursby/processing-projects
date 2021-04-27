import java.util.LinkedList;
import java.util.Arrays;
final int WIDTH = 20;
final int HEIGHT = 20;
final int CSIZE = 30;
final int EMPTY = 0;
final int SNAKE = 1;
final int APPLE = 2;

final int UP = 0;
final int RIGHT = 1;
final int DOWN = 2;
final int LEFT = 3;

final int RUNNING = 0;
final int GAMEOVER = 1;

final int frames = 10;

int inputbuffer = -1;
int gamestate = RUNNING;
int[] grid;
boolean[] pressed; //UP DOWN LEFT RIGHT
LinkedList<Integer> snake;
int currentDir;
int apple;
int snakelen;
int nextstep; //for interpolation
float between; //val from 0 to 1
void settings() {
  size(WIDTH*CSIZE, HEIGHT*CSIZE);
}
void setup() {
  pressed = new boolean[4];
  grid = new int[WIDTH*HEIGHT];
  for (int i = 0; i < grid.length; i++) {
    grid[i] = EMPTY;
  }
  snake = new LinkedList<Integer>();
  snakelen = 2;

  snake.addFirst(id(0, 0));
  snake.addFirst(id(1, 0));
  nextstep = 2;
  //snake.add(id(2, 0));


  currentDir = RIGHT;
}
void draw() {
  //println(Arrays.toString(pressed));

  between = ((float)frameCount % frames)/frames;
  if (gamestate == RUNNING) {
    if (frameCount % frames == 0) {
      update();
    }
    display();
    display2();
  }
}
void update() {
  //println("-----");
  //println("update " + frameCount/frames);
  snake.addFirst(nextstep);
  snake.pollLast();
  //int nextnextstep;
  //println(currentDir);
  if (inputbuffer == 0) {
    if (!((UP - currentDir + 4) % 4 == 2)) {
      currentDir = UP;
    }
  } else if (inputbuffer == 1) {
    if (!((RIGHT - currentDir + 4) % 4 == 2)) {
      currentDir = RIGHT;
    }
  } else if (inputbuffer == 2) {
    if (!((DOWN - currentDir + 4) % 4 == 2)) {
      currentDir = DOWN;
    }
  } else if (inputbuffer == 3) {
    if (!((LEFT - currentDir + 4) % 4 == 2)) {
      currentDir = LEFT;
    }
  }
  inputbuffer = -1;
  println(currentDir);
  switch(currentDir) {
    case(RIGHT):
    nextstep = snake.get(0) + 1;
    break;
    case(LEFT):
    nextstep = snake.get(0) - 1;
    break;
    case(UP):
    nextstep = snake.get(0) - WIDTH;
    break;
    case(DOWN):
    nextstep = snake.get(0) + WIDTH;
    break;
  default:
    nextstep = -1;
  }

  //println(snake);
  //println(nextstep);

  //snake.add(nextstep);
  //snake.poll();


  //display();
}

void display() {
  background(255);
  //int x,y;
  //x = CSIZE*x(snake.get(0));
  //y = CSIZE*y(snake.get(0));
  //int x = CSIZE*x(v);
  //int y = CSIZE*y(v);
  for (int i = 0; i < snake.size(); i++) {
    int v = snake.get(i);
    int x1 = CSIZE*(x(v));
    int y1 = CSIZE*(y(v));
    int x2, y2;
    if (i == 0) {
      x2 = CSIZE*(x(nextstep));
      y2 = CSIZE*(y(nextstep));
    } else {
      x2 = CSIZE*(x(snake.get(i-1)));
      y2 = CSIZE*(y(snake.get(i-1)));
    }
    fill((float)i/snake.size()*255);
    //line(x1, y1, map(between, 0, 1, x1, x2), map(between, 0, 1, x1, x2)
    //rect(map(between, 0, 1, x1, x2), map(between, 0, 1, y1, y2), CSIZE, CSIZE);
  }
}
void display2() {
  //background(255);
  strokeWeight(10);
  for (int i = 0; i < snake.size()-1; i++) {
    int x1 = CSIZE*x(snake.get(i));
    int y1 = CSIZE*y(snake.get(i));
    int x2 = CSIZE*x(snake.get(i+1));
    int y2 = CSIZE*y(snake.get(i+1));
    line(x1, y1, x2, y2);
  }
  int x1 = CSIZE*x(snake.get(0));
  int y1 = CSIZE*y(snake.get(0));
  int x2 = CSIZE*x(nextstep);
  int y2 = CSIZE*y(nextstep);
  line(x1, y1, map(between, 0, 1, x1, x2), map(between, 0, 1, y1, y2));
  x1 = CSIZE*x(nextstep);
  y1 = CSIZE*y(nextstep);
  x2 = CSIZE*x(snake.get(snake.size()-1));
  y2 = CSIZE*y(snake.get(snake.size()-1));
}
void keyPressed() {
  //println(keyCode == java.awt.event.KeyEvent.VK_UP);
  //println(key == CODED);
  if ((keyCode == java.awt.event.KeyEvent.VK_UP && key == CODED) || (key == 'w')) {
    inputbuffer = UP;
    pressed[0] = true;
  } else if ((keyCode == java.awt.event.KeyEvent.VK_RIGHT && key == CODED) || (key == 'd')) {
    inputbuffer = RIGHT;
    pressed[1] = true;
  } else if ((keyCode == java.awt.event.KeyEvent.VK_DOWN && key == CODED) || (key == 's')) {
    inputbuffer = DOWN;
    pressed[2] = true;
  } else if ((keyCode == java.awt.event.KeyEvent.VK_LEFT && key == CODED) || (key == 'a')) {
    inputbuffer = LEFT;
    pressed[3] = true;
  }
  println(Arrays.toString(pressed));
}
void keyReleased() {
  if ((keyCode == java.awt.event.KeyEvent.VK_UP && key == CODED) || key == 'w') {
    pressed[0] = false;
    //return;
  } else if ((keyCode == java.awt.event.KeyEvent.VK_RIGHT && key == CODED) || key == 'd') {
    pressed[1] = false;
    //return;
  } else if ((keyCode == java.awt.event.KeyEvent.VK_DOWN && key == CODED) || key == 's') {
    pressed[2] = false;
    //return;
  } else if ((keyCode == java.awt.event.KeyEvent.VK_LEFT && key == CODED) || key == 'a') {
    pressed[3] = false;
    //return;
  }
  println(Arrays.toString(pressed));
}
int id(int x, int y) {
  return x + y * WIDTH;
}
int x(int id) {
  return id % WIDTH;
}
int y(int id) {
  return id / WIDTH;
}
