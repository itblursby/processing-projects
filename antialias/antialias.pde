boolean antialias = false;
int sample = 6;
void setup() {
  size(300, 300);
  loadPixels();
  //pixelDensity(displayDensity());
  print(displayDensity());
}
int i = 0;
void draw() {
  for (int j = 0; j < 1000; j++) {
    int x = i % width;
    int y = i / width;
    float total = 0;
    for (int xi = 0; xi < sample; xi++){
      for (int yi = 0; yi < sample; yi++){
        float nx = x + xi*(1.0/sample);
        float ny = y + yi*(1.0/sample);
        if ((nx-width/2)*(nx-width/2)+(ny-height/2)*(ny-height/2) < 10000) {
          total += 1;
        }
      }
    }
    pixels[i] = color(255*(total/sample)/sample);
    i++;
    if (i == width * height) {
      noLoop();
      break;
    }
  }
  updatePixels();
}
