PImage pic;
int[] lumvalues;
PrintWriter p;

void setup() {
  background(255);
  p = createWriter("textoutput.txt");
  size(400, 400);
  pic = loadImage("gradient1.png");
  pic.loadPixels();
  lumvalues = new int[pic.pixels.length];
  image(pic,0,0);
}
int pixelIndex = 0;
void draw() {
  lumvalues[pixelIndex] = luminance(pic.pixels[pixelIndex]);
  pixel++;
  
}

int luminance(color a) {
  int s = round(0.2989*red(a)+0.5870*green(a)+0.1140*blue(a));
  if (s > 255) {
    s = 255;
  }
  return s;
}
