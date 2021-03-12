PShader frag;
final int AMOUNT = 5;
float dense = 1;
Circle[] circles = new Circle[AMOUNT];
float[] posx = new float[AMOUNT];
float[] posy = new float[AMOUNT];
float[] rad = new float[AMOUNT];
float[] spin = new float[AMOUNT];

void setup() {
  size(600, 600, P2D);
  dense = displayDensity();
  pixelDensity(displayDensity());
  for (int i = 0; i < AMOUNT; i++) {
    circles[i] = new Circle();
  }
  frag = loadShader("frag.glsl");
  frag.set("dense", dense);
  frameRate(60);
}
void draw() {
  for (int i = 0; i < AMOUNT; i++){
    circles[i].update();
  }
  background(0);
  //resetShader();
  shader(frag);
  rect(0, 0, width, height);
}
