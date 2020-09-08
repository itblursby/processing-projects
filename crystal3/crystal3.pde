final int scale = 600; //pereferably something that divides the width/height
final int samples = 4;
final int margin = 10;
final int circles = 1;
int realwidth;
int realheight;
Turn[] turns = new Turn[circles];
int dense;
PVector test = new PVector(0, 0);

void setup() {
  size(620, 720);
  realwidth = width-margin-margin;
  realheight = height-margin-margin;
  pixelDensity(displayDensity());
  dense = displayDensity();
  for (int i = 0; i < turns.length; i++) {
    turns[i] = new Turn(width*random(1), height*random(1), width/8+width/8*random(1), random(1)*TAU);
  }
  turns[0] = new Turn(0,0,100,PI);
}

void draw() {
  turns[0].setPos(mouseX, mouseY);
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
  return color(255f/(scale>>1)*abs((x%scale)-(scale>>1)), 255f/(scale>>1)*abs((y%scale)-(scale>>1)), 255);
}
