int cellsize = 2;
color dead = color(0, 0, 0);
color alive = color(255, 255, 255);

int[][] cells; 
int[][] ncells; 
int cwidth;
int cheight;

void setup() {
  print(-2%7);
  //pixelDensity(displayDensity());
  size(400, 400);
  noStroke();
  cwidth = floor(width/cellsize);
  cheight = floor(height/cellsize);
  cells = new int[cwidth][cheight];
  ncells = new int[cwidth][cheight];
  for (int i = 0; i < cwidth; i++) {
    for (int j = 0; j < cheight; j++) {
      cells[i][j] = 1;
      if (random(1)>0.1){
        cells[i][j] = 0;
      }
    }
  }
  frameRate(20);
}

void draw() {
  background(dead);

  for (int i = 0; i < cwidth; i++) {
    for (int j = 0; j < cheight; j++) {
      if (cells[i][j] == 1) {
        fill(alive);
        rect(i*cellsize, j*cellsize, cellsize, cellsize);
        if (countcells(i, j, 1) < 5) {
          ncells[i][j] = 1;
        }else{
          ncells[i][j] = 0;
        }
      } else if (cells[i][j] == 0) {
        
        if (countcells(i, j, 1) == 3) {
          ncells[i][j] = 1;
        }else{
          ncells[i][j] = 0;
        }
        
      }
    }
  }
  for (int i = 0; i < cwidth; i++) {
    for (int j = 0; j < cheight; j++) {
      cells[i][j] = ncells[i][j];
    }
  }
}
void keyPressed() {
  if (key == ' ') {
    setup();
  }
  if (key == '0') {
    for (int i = 0; i < cwidth; i++) {
      for (int j = 0; j < cheight; j++) {
        ncells[i][j] = 0;
        cells[i][j] = 0;
      }
    }
  }
}
int countcells(int x, int y, int index) {
  int alivecells = 0;
  int iplus1 = (x+1+cwidth)%cwidth;
  int iminus1 = (x-1+cwidth)%cwidth;
  int jplus1 = (y+1+cheight)%cheight;
  int jminus1 = (y-1+cheight)%cheight;

  if (cells[iplus1][y] == index) {
    alivecells++;
  }
  if (cells[iplus1][jminus1] == index) {
    alivecells++;
  }
  if (cells[x][jminus1] == index) {
    alivecells++;
  }
  if (cells[iminus1][jminus1] == index) {
    alivecells++;
  }
  if (cells[iminus1][y] == index) {
    alivecells++;
  }
  if (cells[iminus1][jplus1] == index) {
    alivecells++;
  }
  if (cells[x][jplus1] == index) {
    alivecells++;
  }
  if (cells[iplus1][jplus1] == index) {
    alivecells++;
  }
  return alivecells;
}
