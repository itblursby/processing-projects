Cell[][] particles;
int size = 3;
void setup() {  
  frameRate(200);
  noStroke();
  fill(0);
  size(400, 400);
  particles = new Cell[ceil(width/size)][ceil(height/size)];
  for (int i = 0; i < particles.length; i++) {
    for (int j = 0; j < particles[0].length; j++) {
      if (random(1)>0.1) {
        particles[i][j] = new Cell(false, false);
      } else {
        particles[i][j] = new Cell(true, true);
      }
    }
  }
  
}
void draw() {
  background(255);
  noStroke();
  if (mousePressed){
    particles[round(mouseX/size)][round(mouseY/size)] = new Cell(true,true);
  }
  for (int i = 0; i < particles.length; i++) {
    for (int j = particles[0].length-1; j > -1; j--) {
      Cell c = particles[i][j];
      if ((c.state == true)&&(c.active == true)) {
        if (j == particles[0].length-1) {
          c.active = false;
        } else {

          if (particles[i][j+1].state == false) {
            particles[i][j+1].state = true;
            particles[i][j+1].active = true;
            particles[i][j].state = false;
            particles[i][j].active = false;
          } else if (i - 1 > -1&&particles[i-1][j+1].state == false) {

            particles[i-1][j+1].state = true;
            particles[i-1][j+1].active = true;
            particles[i][j].state = false;
            particles[i][j].active = false;
          } else if (i + 1 < particles.length&&particles[i+1][j+1].state == false) {
            particles[i+1][j+1].state = true;
            particles[i+1][j+1].active = true;
            particles[i][j].state = false;
            particles[i][j].active = false;
          } else {
            c.active = false;
          }
        }
      }
    }
  }
  for (int i = 0; i < particles.length; i++) {
    for (int j = particles[0].length-1; j > -1; j--) {
      if (particles[i][j].state == true) {
        
        rect(i*size, j*size, size, size);
      }
    }
  }
}
