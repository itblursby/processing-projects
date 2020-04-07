int iter = 100; //number of iterations
int power = 2; //power in z = z^[power] + c
float window = 4; //viewing window size
Complex pos = new Complex(-2, -2); //position at top right corner of viewing window
void setup() {
  size(200, 200);
}
void draw() {
  background(0);
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float real = 0.0 + pos.getReal() + x*(window/width);
      float imag = 0.0 + pos.getImag() + (-y)*(window/height);
      Complex c = new Complex(real, imag);
      Complex z = new Complex(0,0);
      int i;
      stroke(0);
      for (i = 0; i < iter; i++){
        z = z.sq();
        z.add(c);
        if (z.absqr()>4){
          stroke(255);
        }
      }
      point(x,y);
    }
  }
}
