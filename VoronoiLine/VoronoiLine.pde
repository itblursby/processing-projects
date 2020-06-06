int numlines = 50;
int a = 0;
Line[] lines = new Line[numlines];
void setup() {
  size(1440, 900);
  pixelDensity(displayDensity());
  for (int i = 0; i < numlines; i++) {
    lines[i] = new Line(new PVector(random(0, pixelWidth), random(0, pixelHeight)), new PVector(random(0, pixelWidth), random(0, pixelHeight)));
  }
}

void draw() {
  background(0);
  loadPixels();
  for (int i = 0; i < pixelWidth; i++) {
    for (int j = 0; j < pixelHeight; j++) {
      int index = -1;
      int sindex = -1;
      float leng = Float.MAX_VALUE;
      float sleng = Float.MAX_VALUE;
      for (int k = 0; k < lines.length; k++) {
        float temp = lines[k].distToPoint(new PVector(i, j));
        if (temp < sleng) {
          sleng = temp;
          sindex = k;
          if (temp < leng) {
            int tindex = index + 0;
            float tleng = leng +0;
            index = sindex + 0;
            leng = sleng + 0;
            sindex = tindex + 0;
            sleng = tleng + 0;
          }
        }
      }
      
      //if (sleng - leng > a) {
      //  float s = smoothstep(a,a+10,sleng - leng);
      //  color c = lines[index].col;
      //  pixels[j*pixelWidth+i] = color(red(c)*s,green(c)*s,blue(c)*s);
      //}
      color c = lines[index].col;
      pixels[j*pixelWidth+i] = c;
    }
  }
  updatePixels();
  //for (int i = 0; i < numlines; i++) {
  //  lines[i].display();
  //}
  noLoop();
  saveFrame();
}
float smoothstep(float min, float max, float val) {
  if (val >= max) {
    return 1;
  } else if (val <= min) {
    return 0;
  } else {
    return (val-min)/(max-min);
  }
}
