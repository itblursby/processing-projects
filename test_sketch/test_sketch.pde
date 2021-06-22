PGraphics pg;
void setup() {
  size(600, 600);
  pg = this.g;
  background(255);
  //pg = createGraphics(100, 100);
  //pg.smooth();
  //pg.beginDraw();
  //pg.stroke(0);
  //pg.strokeWeight(1);
}
void draw() {
  ellipse(mouseX,mouseY,20,20);
  pg.loadPixels();
  image(pg,100,100);
  //pg.beginDraw();
  //pg.image(pg,100,0,600,600);
  //pg.endDraw();
  //p
}
//void mousePressed() {
//  ellipse(mouseX, mouseY, 20, 20);
//}
