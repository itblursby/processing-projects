private PShader shifty;
private int display = 1;
//private PImage img;
private final int AMOUNT = 20;
private Shift[] shifts = new Shift[AMOUNT];

private float[] pos1 = new float[AMOUNT];
private float[] pos2 = new float[AMOUNT];
private float[] shift = new float[AMOUNT];
private boolean[] orient = new boolean[AMOUNT];
private float[] col = new float[AMOUNT];

void setup() {
  //img = loadImage("floyd.png");
  size(600, 600, P2D);
  display = displayDensity();
  pixelDensity(displayDensity());
  shifty = loadShader("frag.glsl");

  for (int i = 0; i < AMOUNT; i++) {
    shifts[i] = new Shift(1);
  }
  shifty.set("disDensity", (float)display);
  for (int i = 0; i < AMOUNT; i++) {
    orient[i] = shifts[i].getOrientation();
  }
  for (int i = 0; i < AMOUNT; i++) {
    col[i] = shifts[i].getCol();
  }
  shifty.set("orient",orient);
  //shifty.set("img", img);
  frameRate(60);
}

void draw() {
  //background(255);
  for (int i = 0; i < AMOUNT; i++) { 
    shifts[i].update();
    //println("------");
    //println(java.util.Arrays.toString(pos1));
    //println(java.util.Arrays.toString(pos2));
    //println(java.util.Arrays.toString(shift));
    //println(java.util.Arrays.toString(orient));
    pos1[i] = shifts[i].getPos1();
    pos2[i] = shifts[i].getPos2();
    shift[i] = shifts[i].getShift();
    //orient[i] = shifts[i].getOrientation();
    //col[i] = shifts[i].getCol();
  }
  //println(pos1[0]);
  //print(display);


  shifty.set("pos1", pos1);
  shifty.set("pos2", pos2);
  shifty.set("shift", shift);
  //shifty.set("orient", orient);
  shifty.set("res", (float)width, (float)height);
  shifty.set("col", col);

  shader(shifty);
  rect(0, 0, width, height);
  resetShader();
  //rect(mouseX,mouseY,100,100);
  //saveFrame("frames1/mystery####.png");
}
void keyPressed() {
  if (key == 'p') {
    saveFrame("frames/art.png");
  }
}
