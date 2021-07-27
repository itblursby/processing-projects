void setup() {
  size(200, 200);
  colorMode(HSB, 200);
}
void draw() {
  loadPixels();
  for (int x = 0; x < 200; x++) {
    for (int y = 0; y < 200; y++) {
      //println(((mouseX-100)*x + (mouseY-100)*y)/(dist(mouseX,mouseY,100,100)*dist(100,100,x,y)));
      if (y < 100) {
        pixels[x+y*200] = color(200/TAU*acos(((100)*(x-100) + 0*(y-100))/(100*dist(x, y, 100, 100))), 200, 200);
      } else {
        pixels[x+y*200] = color(200-200/TAU*acos(((100)*(x-100) + 0*(y-100))/(100*dist(x, y, 100, 100))), 200, 200);
      }
    }
  }
  updatePixels();
    saveFrame();

}
