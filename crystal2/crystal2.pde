Shift[] arr = new Shift[4];
void setup() {
  size(375, 667);
  for (int i = 0; i < arr.length; i++) {
    if (random(1)>0.5) {
      arr[i] = new Shift(floor(random(height)), floor(random(height/2)), floor(random(width/4, width/2)), true);
    } else {
      arr[i] = new Shift(floor(random(width)), floor(random(width/2)), floor(random(height/4, height/2)), false);
    }
  }
}
int count = 0;
void draw() {
  for (int i = 0; i < 1000; i++) {
    pointAt(count%width, count/width);
    count++;
  }
  if (count > width * height) {
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
  return color(255,2*255*min(a, 1-a),2*255*(min(b, 1-b)));
}
void pointAt(int x, int y) {
  int[] c = new int[] {x, y};
  for (int i = 0; i < arr.length; i++) {
    c = arr[i].getNew(c[0], c[1]);
  }
  stroke(getColor((float)c[0]/width, (float)c[1]/height));
  point(x, y);
}
