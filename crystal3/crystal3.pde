final int scale = 600; //pereferably something that divides the width/height
final int samples = 4;
final int margin = 10;
final int circles = 20;
final int color1 = 0xffc46008;
final int color2 = 0xffbfab3b;
final int color3 = 0xff6c22a1;
final int color4 = 0xff3eaac2;

int realwidth;
int realheight;
int realsize;
Turn[] turns = new Turn[circles];
int dense;
PVector test = new PVector(0, 0);

void setup() {
  size(620, 620);
  realwidth = width-margin-margin;
  realheight = height-margin-margin;
  realsize = min(realwidth,realheight);
  pixelDensity(displayDensity());
  dense = displayDensity();
  for (int i = 0; i < turns.length; i++) {
    float radius = realsize/8+realsize/8*random(1);
    turns[i] = new Turn(random(radius,realwidth-radius), random(radius,realheight-radius), radius, PI+0*(random(1)-0.5)*TAU/10);
  }
  //turns[0] = new Turn(0,0,100,PI);
}

void draw() {
  //turns[0].setPos(mouseX, mouseY);
  //turns[0].setAngle(frameCount/30.0);
  loadPixels();
  for (int x = 0; x < pixelWidth-margin*4; x++) {
    for (int y = 0; y < pixelHeight-margin*4; y++) {
      //test.set(x, y);
      pixels[(x+margin*2)+((y+margin*2)*pixelWidth)] = getAvgColor((float)x/dense, (float)y/dense);
    }
  }
  updatePixels();
  //noLoop();
  //saveFrame();
}
int getAvgColor(float x, float y) {
  float avgred = 0;
  float avggreen = 0;
  float avgblue = 0;
  for (int i = 0; i < samples; i++) {
    for (int j = 0; j < samples; j++) {
      test.set(x+i/((float)samples*dense), y+i/((float)samples*dense));
      int col = getExactColor(test);
      avgred += (col >> 16) & 0xFF;
      avggreen += (col >> 8) & 0xFF;
      avgblue += (col) & 0xFF;
    }
  }
  avgred /= samples*samples;
  avggreen /= samples*samples;
  avgblue /= samples*samples;
  return color(avgred, avggreen, avgblue);
}
int getExactColor(PVector p) {
  for (int i = 0; i < turns.length; i++) {
    turns[i].change(p);
  }
  return getBG(p.x, p.y);
}
int getBG(float x, float y) {
  x = (x%scale)/scale;
  y = (y%scale)/scale;
  return color(lerpColor(lerpColor(color1,color2,x),lerpColor(color3,color4,x),y));
}
