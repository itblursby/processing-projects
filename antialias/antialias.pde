boolean antialias = false;
int sample = 10;
int dense = 2;
void setup() {
  size(300, 300);
  loadPixels();
  pixelDensity(dense);
  print(dense);
  
}
int i = 0;
void draw() {
  for (int j = 0; j < 1000; j++) {
    int x = i % pixelWidth;
    int y = i / pixelWidth;
    float total = 0;
    for (int xi = 0; xi < sample; xi++){
      for (int yi = 0; yi < sample; yi++){
        float nx = x + xi*(1.0/sample);
        float ny = y + yi*(1.0/sample);
        if ((nx-pixelWidth/2)*(nx-pixelWidth/2)+(ny-pixelWidth/2)*(ny-pixelWidth/2) < dense*dense*10000) {
          total += 1;
        }
      }
    }
    pixels[i] = color(255*(total/sample)/sample);
    i++;
    if (i == pixelWidth * pixelHeight) {
      noLoop();
      saveFrame("antialias.png");
      break;
    }
  }
  updatePixels();
}
