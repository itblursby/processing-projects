PImage bg;
Shift[] arr = new Shift[40];
void setup() {
  bg = loadImage("sky.png");
  bg.loadPixels();
  size(600, 600);
  for (int i = 0; i < arr.length; i++) {
    if (random(1)>0.5) {
      arr[i] = new Shift(floor(random(height)), floor(random(height/2)), floor(random(width/4, width/2)), true, random(100));
    } else {
      arr[i] = new Shift(floor(random(width)), floor(random(width/2)), floor(random(height/4, height/2)), false, random(100));
    }
  }
  loadPixels();
  colorMode(HSB,256);
}
int count = 0;
void draw() {
  
  for (int i = 0; i < 1000; i++) {
    if (count > width * height) {
      break;
    }
    pointAt(count%width, count/width);
    count++;
  }
  updatePixels();
  if (count >= width * height) {
    updatePixels();
    saveFrame();
    noLoop();
  }
  //for (int x = 0; x < width; x++) {
  //  for (int y = 0; y < height; y++) {
  //    pointAt(x,y);
  //    //int[] c = new int[] {x, y};
  //    //for (int i = 0; i < arr.length; i++) {
  //    //  c = arr[i].getNew(c[0], c[1]);
  //    //}
  //    //stroke(getColor((float)c[0]/width,(float)c[1]/height));
  //    //point(x, y);
  //  }
  //}
}
color getColor(float a, float b) {
  return color(255, 2*255*min(a, 1-a), 2*255*(min(b, 1-b)));
}
void pointAt(int x, int y) {
  int[] c = new int[] {x, y};
  int black = 0;
  for (int i = 0; i < arr.length; i++) {
    if (arr[i].isWithin(c[0], c[1])) {
      black++;
    }
    c = arr[i].getNew(c[0], c[1]);
  }
  if (black%2 == 0) {
    pixels[x+y*width] = color(map(x,0,600,0,10),256,256);
    //stroke(0);
  }else if (black%3 == 1||true){
    ////stroke(random(255));
    //int col = (getColor((float)x/width, (float)y/height));
    //pixels[x+y*width] = bg.pixels[x+y*width];
    //pixels[x+y*width] = color(0,0,255);
    pixels[x+y*width] = color(map(x,0,600,10,0)%256,256,256);
    //stroke(getColor((float)x/width, (float)y/height));
  }else if (black%3 == 2){
    pixels[x+y*width] = color(255,255,0);
        pixels[x+y*width] = color(map(x,0,600,20,276)%256,256,256);

  }
  
  //stroke(getColor((float)c[0]/width, (float)c[1]/height));
  //point(x, y);
}
