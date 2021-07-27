public boolean pMousePressed = false;
public boolean nMousePressed = false;
DragCircle init1;
DragCircle init2;
DragCircle init3;

void setup() {
  size(600, 600);
  pixelDensity(displayDensity());
  init1 = new DragCircle(random(200, 400), random(200, 400),10);
  init2 = new DragCircle(random(200, 400), random(200, 400),10);
  init3 = new DragCircle(random(200, 400), random(200, 400),10);
}

float px, py, dist, dx, dy, dist2;
void draw() {
  background(255);
  updateMouse();
  init1.move();
  init2.move();
  init3.move();
  init1.display();
  init2.display();
  init3.display();
  //dist = dist(mouseX, 300, 300, 300);
  //dx = (mouseX-300);
  //dy = 0;
  //px = 300+dx*pow(100/dist, 2);
  //py = 300+dy*pow(100/dist, 2);
  ////ellipse(300,300,200,200);
  //dist2 = dist(px, py, 300, 300);
  //if (dist2 < 30000) {
  //  ellipse(px, py, dist2*2, dist2*2);
  //} else {
  //  line(300, 0, 300, 600);
  //}
}
void updateMouse() {
  pMousePressed = nMousePressed;
  nMousePressed = mousePressed;
}
