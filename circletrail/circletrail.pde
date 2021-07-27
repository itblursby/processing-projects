Traveler[] points = new Traveler[10];
void setup() {

  size(600, 600);  
  pixelDensity(displayDensity());
  colorMode(HSB, 100);
  background(9, 23, 77);
  noStroke();
  fill(255, 0, 0);
  for (int i = 0; i < points.length; i++) {
    points[i] = new Traveler();
  }
}
void draw() {
  if (frameCount % 20 == 0) {
    for (int i = 0; i < points.length; i++) {
      points[i] = new Traveler();
    }
  }

  for (int i = 0; i < points.length; i++) {

    points[i].accel(300, 300);
    points[i].iterate();

    points[i].display();
  }
  //noFill();
  //stroke(255);
  //float d = dist(mouseX, mouseY, pmouseX, pmouseY);
  //ellipse((mouseX+pmouseX)/2, (mouseY+pmouseY)/2, d, d);
}
void keyPressed() {
  if (key == '1') {
    background(9, 23, 77);
  }
  if (key =='2') {
    saveFrame("frame#####.png");
  }
}
