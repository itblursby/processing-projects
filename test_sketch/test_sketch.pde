float noiseScale = 10;
void setup() {
  noiseSeed(235);
  size(200,200);
  noiseDetail(1);
  loadPixels();
  for (int x = 0; x < width; x++){
    for (int y = 0; y < height; y++){
      pixels[x+y*width] = color(2*255*noise(x/noiseScale,y/noiseScale));
    }
  }
  updatePixels();
  saveFrame();
}
