
PShader frag;
float scale = 10;
float strength = 30;
int iterations = 1;
float offsetx = -481.2;
float offsety = 599.1;
float lwidth = 6;
float dist = 20;
int circles = 50;
float[] circlesx = new float[circles];
float[] circlesy = new float[circles];
//void load(){
//}
PoissonDisk pd;
void setup() {
  size(600, 600, P2D);
  frag = loadShader("frag.glsl");
  frameRate(60);
  pixelDensity(displayDensity());
  frag.set("res", (float) width, (float) height);
  frag.set("display", (float) displayDensity());
  frag.set("scale", scale);
  frag.set("strength", strength);
  frag.set("offset", offsetx, offsety);
  frag.set("iterations", iterations);
  frag.set("dist", dist);
  frag.set("lwidth",lwidth);
  pd = new PoissonDisk(width/2., height/2., dist*2);
  for (int i = 0; i < circles; i++) {
    PVector vec = pd.next();
    circlesx[i] = vec.x;
    circlesy[i] = vec.y;
  }
  frag.set("circlesx", circlesx);
  frag.set("circlesy", circlesy);




  //frag.set("offset",
}
int a = 0;
float s = 10;
//PerlinNoise pn = new PerlinNoise();
void draw() {
  frag.set("mouse", (float)mouseX, height-(float)mouseY);
  //frag.set("itime", millis()/1000.);

  //background(255);

  shader(frag);
  rect(0, 0, width, height);
}
void keyPressed() {
  if (key == '1') {
    saveFrame("frame-####.png");
  }
}
