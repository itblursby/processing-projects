int spread = 5;

void setup() {
  size(300, 300);
  pixelDensity(displayDensity());
  loadPixels();
  //colorMode(HSB, 100);
  for (int i = 0; i < pixelWidth*pixelHeight; i++) {
    pixels[i] = (((i/pixelWidth)+(i%pixelWidth))%2==0)?color(255):color(0, 0, 0);
  }
  updatePixels();
}
void draw() {
  //background(0);
  //float begin = random(height);
  //float hei = random(height-begin);
  //image(bg,0,begin,300,hei);
  //if (frameCount > 20) {
  for (int i = 0; i < 100000; i++) {
    int a1 = (int)random(0, pixelWidth*pixelHeight);
    //for (int j = 0; j < 4; j++) {
    int a2 = (rb()?(rb()?1:-1):((rb()?1:-1)*pixelWidth));
    //int a2 = a1 + (int)(random(spread*2)-spread) + (int)(random(spread*2)-spread)*width;

    if (a1+a2 >= 0 && a1+a2 < pixelWidth*pixelHeight) {


      pixels[a1] = pixels[a1+a2];
      //println(pixels[a1]);
    }
  }
  updatePixels();
}
boolean rb() {
  return random(1)>0.5;
}
