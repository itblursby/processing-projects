int noiseScale = 10;
float[][] values;
void setup() {
  randomSeed(482);
  size(200, 200);
  values = new float[width/noiseScale+1][height/noiseScale+1];
  for (int x = 0; x < width/noiseScale+1; x++) {
    for (int y = 0; y < height/noiseScale+1; y++) {
      values[x][y] = random(1);
    }
  }
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      //AB
      //CD
      float A = values[x/noiseScale][y/noiseScale];
      float B = values[x/noiseScale+1][y/noiseScale];
      float C = values[x/noiseScale][y/noiseScale+1];
      float D = values[x/noiseScale+1][y/noiseScale+1];
      float xsub = x/(float)noiseScale - x/noiseScale;
      float ysub = y/(float)noiseScale - y/noiseScale;
      //A+xsub*(B-A)
      //C+xsub*(D-C)

      pixels[x+y*width] = color(255*Ex(ysub, Ex(xsub, A, B), Ex(xsub, C, D)));
    }
  }
  updatePixels();
  saveFrame();
}

//extrapolates between A and B with value t from 0 to 1.
float Ex(float t, float A, float B) {
  //float t1 =  6*pow(t, 5)-15*pow(t, 4)+10*pow(t, 3);
  float t1 = 3*t*t-2*t*t*t;
  return A+t1*(B-A);
}
