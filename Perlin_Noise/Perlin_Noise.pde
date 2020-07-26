float a = 21.3, 
  b = 48.2, 
  c = 385.2;
float noiseScale = 100;
void setup() {
  size(600, 600);
  //noiseDetail(4,0.5);
}
int p = 0;
float x, y;
void draw() {
  loadPixels();
  for (int i = 0; i < 1000; i++) {

    float x = p%width;
    float y = p/width;
    float n = newnoise(x/noiseScale, y/noiseScale);


    pixels[p] = color((n+1)*255/2);    
    //if (n > 0) {
    //  pixels[p] = color(255-(n)*255, 255, 255);
    //} else {
    //  pixels[p] = color(255, 255, 255-(-n)*255);
    //}
    p++;
    if (p >= pixels.length) {
      print("bruh");
      break;
    }
  }
  updatePixels();
  if (p >= width*height) {
    print("bruh");
    saveFrame();
    noLoop();
  }
}

float hash(float x, float y) {
  return abs(pow((a+b*x+c*y)%(138), 3)%1);
}
float extrapo(float t) {
  return 6*pow(t, 5)-15*pow(t, 4)+10*pow(t, 3);
  //if (t > 0.5) {
  //  return 1;
  //}
  //return 0;
}
float newnoise(float x, float y) {
  int x1 = floor(x);
  int y1 = floor(y);
  float xr = extrapo(x - floor(x));
  float yr = extrapo(y - floor(y));
  float[] e = new float[4];
  e[0] = dis(x1, y1, x, y, hash(x1, y1));
  e[1] = dis(x1+1, y1, x, y, hash(x1+1, y1));
  e[2] = dis(x1, y1+1, x, y, hash(x1, y1+1));
  e[3] = dis(x1+1, y1+1, x, y, hash(x1+1, y1+1));
  float n1 = (e[0]+(e[1]-e[0])*xr);
  float n2 = (e[2]+(e[3]-e[2])*xr);
  return n1+yr * (n2-n1);
}
float dis(float ox, float oy, float tx, float ty, float t) {
  return cos(t*TAU)*(tx-ox)+sin(t*TAU)*(ty-oy);
}
