boolean antialias = false;
int sample = 4;
int dense = 2;
int npw; 
int nph;
void setup() {
  size(320, 320);
  npw = pixelWidth-20;
  nph = pixelHeight-20;
  //surface.setResizable(true);
  loadPixels();
  pixelDensity(dense);
  print(dense);
  
}
int i = 0;
void draw() {
  for (int j = 0; j < 1000; j++) {
    int x = i % npw;
    int y = i / npw;
    float total = 0;
    for (int xi = 0; xi < sample; xi++){
      for (int yi = 0; yi < sample; yi++){
        float nx = x + xi*(1.0/sample);
        float ny = y + yi*(1.0/sample);
        if ((nx-npw/2)*(nx-npw/2)+(ny-npw/2)*(ny-npw/2) < dense*dense*10000) {
          total += 1;
        }
      }
    }
    pixels[10+x+(y+10)*pixelHeight] = color(255*(total/sample)/sample);
    i++;
    println(i);
    if (i == npw * nph) {
      updatePixels();
      noLoop();
      saveFrame("antialias.png");
      break;
    }
  }
  updatePixels();
}
