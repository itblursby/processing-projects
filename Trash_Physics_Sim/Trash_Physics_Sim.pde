int cir = 40;
Circle[] c = new Circle[cir];
int drag = -1;
float ag = 1;
float min = 50;
float max = 100;
void setup() {
  pixelDensity(1);
  size(600, 600);
  generate((int)min, (int)max);
  frameRate(60);
}
void draw() {
  background(25);
  fill(255);
  stroke(0);
  strokeWeight(1);

  for (Circle i : c) {
    i.move();
  }
  if (drag > -1) {
    if (!mousePressed) {
      drag = -1;
    } else {
      c[drag].set_new_center(mouseX, mouseY);
    }
  }
  constrain();

  for (int i = 0; i < cir; i++) {
    c[i].iterate();
    fill(255);
    stroke(0);
    strokeWeight(1);
    c[i].display();
  }
}
void collide() {
  float overlap = 0;
  for (int f = 0; f < cir; f++) {
    for (int g = f+1; g < cir; g++) {
      if (f != g) {
        Circle m = c[f];
        Circle n = c[g];
        if (abs(m.nx-n.nx)<(m.d+n.d)/2) {
          if (abs(m.ny-n.ny)<(m.d+n.d)/2) {
            if (((m.d+n.d)*(m.d+n.d))/4>((m.nx-n.nx)*(m.nx-n.nx)+(m.ny-n.ny)*(m.ny-n.ny))) {
              float dismn = dis(m.nx, m.ny, n.nx, n.ny);
              overlap = ((m.d+n.d)/2)-dismn;

              float overlapx = (overlap/(dismn))*(m.nx-n.nx);
              float overlapy = (overlap/(dismn))*(m.ny-n.ny);

              m.set_new_center(m.nx+ag*overlapx*(pow(n.d, 2)/(pow(n.d, 2)+pow(m.d, 2))), m.ny+ag*overlapy*(pow(n.d, 2)/(pow(n.d, 2)+pow(m.d, 2))));
              n.set_new_center(n.nx-ag*overlapx*(pow(m.d, 2)/(pow(n.d, 2)+pow(m.d, 2))), n.ny-ag*overlapy*(pow(m.d, 2)/(pow(n.d, 2)+pow(m.d, 2))));
            }
          }
        }
      }
    }
  }
  for (Circle f : c) {
    if (f.nx+f.d/2>width) {
      f.set_new_center(width-f.d/2, f.ny);
    }
    if (f.nx-f.d/2<0) {
      f.set_new_center(f.d/2, f.ny);
    }
    if (f.ny+f.d/2>height) {
      f.set_new_center(f.nx, height-f.d/2);
    }
    if (f.ny-f.d/2<0) {
      f.set_new_center(f.nx, f.d/2);
    }
  }
}

void generate(int min, int max) {
  for (int i = 0; i < cir; i++) {
    c[i] = new Circle(random(width), random(height), random(min, max));
  }
}
float dis(float x1, float y1, float x2, float y2) {
  return sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2));
}
void constrain() {
  for (int t = 0; t < 10; t++) {
    collide();
  }
}

void mousePressed() {
  for (int g = 0; g < cir; g++) {
    if (dis(c[g].x, c[g].y, mouseX, mouseY)<c[g].d/2) {
      drag = g;
    }
  }
}
