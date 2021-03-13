PShader frag;
final int AMOUNT = 20;
float dense = 1;
Circle[] circles = new Circle[AMOUNT];
float[] posx = new float[AMOUNT];
float[] posy = new float[AMOUNT];
float[] rad = new float[AMOUNT];
float[] sine = new float[AMOUNT];
float[] cosine = new float[AMOUNT];


void setup() {
  size(600, 600, P2D);
  dense = displayDensity();
  pixelDensity(displayDensity());
  for (int i = 0; i < AMOUNT; i++) {
    circles[i] = new Circle();
  }
  frag = loadShader("frag.glsl");
  frag.set("dense", dense);
  frag.set("res", width*1., height*1.);
  frameRate(60);
}
void draw() {
  background(0);
  resetShader();

  for (int i = 0; i < AMOUNT; i++) {
    circles[i].update();

    posx[i] = circles[i].getX();
    posy[i] = circles[i].getY();
    rad[i] = circles[i].getRad();
    sine[i] = sin(circles[i].getAngle());
    cosine[i] = cos(circles[i].getAngle());

    frag.set("posx", posx);
    frag.set("posy", posy);
    frag.set("rad", rad);
    frag.set("sine", sine);
    frag.set("cosine", cosine);
  }
  //frag.set("mouse", mouseX*1., mouseY*1.);

  shader(frag);
  rect(0, 0, width, height);
  //for (Circle a : circles) {
  //  a.display();
  //}
}
