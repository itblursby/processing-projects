int x = 300;
int y = 300;
boolean left = false;
boolean right = false;
boolean up = false;
boolean down = false;

void setup() {
  size(600, 600);
}
void draw() {
  print(keyCode);
  background(255);
  if (left) {
    x -= 1;
  } else if (right) {
    x +=1 ;
  }
  if (up) {
    y -=1 ;
  } else if (down) {
    y += 1;
  }
  x = x % width;
  y = y % height;
  ellipse(x, y, 10, 10);
}
void keyPressed() {
  if (keyCode == LEFT) {
    left = true;
  }
  if (keyCode == RIGHT) {
    right = true;
  }
  if (keyCode == UP) {
    up = true;
  }
  if (keyCode == DOWN) {
    down = true;
  }
}
void keyReleased() {
  if (keyCode == LEFT) {
    left = false;
  }
  if (keyCode == RIGHT) {
    right = false;
  }
  if (keyCode == UP) {
    up = false;
  }
  if (keyCode == DOWN) {
    down = false;
  }
}
