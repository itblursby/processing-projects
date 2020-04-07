int cellsize = 5;
color dead = color(0, 0, 0);
color dying = color(255, 0, 0);
color alive = color(255, 150, 0);

int[][] cells; 
int[][] ncells; 
int cwidth;
int cheight;

void setup() {
  //pixelDensity(displayDensity());
  size(600, 600);
  noStroke();
  cwidth = floor(width/cellsize);
  cheight = floor(height/cellsize);
  cells = new int[cwidth][cheight];
  ncells = new int[cwidth][cheight];
  for (int i = 0; i < cwidth; i++) {
    for (int j = 0; j < cheight; j++) {
      cells[i][j] = floor(random(3));
    }
  }
  frameRate(10);
}

void draw() {
  background(dead);

  for (int i = 0; i < cwidth; i++) {
    for (int j = 0; j < cheight; j++) {
      if (cells[i][j] == 1) {
        fill(dying);
        rect(i*cellsize, j*cellsize, cellsize-1, cellsize-1);
        ncells[i][j] = 0;
      } else if (cells[i][j] == 2) {
        fill(alive);
        rect(i*cellsize, j*cellsize, cellsize-1, cellsize-1);
        ncells[i][j] = 1;
      } else {
        int alivecells = 0;
        int iplus1 = (i+1+cwidth)%cwidth;
        int iminus1 = (i-1+cwidth)%cwidth;
        int jplus1 = (j+1+cheight)%cheight;
        int jminus1 = (j-1+cheight)%cheight;

        if (cells[iplus1][j] == 2) {
          alivecells++;
        }
        if (cells[iplus1][jminus1] == 2) {
          alivecells++;
        }
        if (cells[i][jminus1] == 2) {
          alivecells++;
        }
        if (cells[iminus1][jminus1] == 2) {
          alivecells++;
        }
        if (cells[iminus1][j] == 2) {
          alivecells++;
        }
        if (cells[iminus1][jplus1] == 2) {
          alivecells++;
        }
        if (cells[i][jplus1] == 2) {
          alivecells++;
        }
        if (cells[iplus1][jplus1] == 2) {
          alivecells++;
        }
        if (alivecells == 2) {
          ncells[i][j] = 2;
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
}
