void setup() {
  size(300, 300);
  image(loadImage("test.png"), 0, 0);
  loadPixels();
}
int a = 0;
float errorred;
float errorgreen;
float errorblue;
float errors[] = new float[4];
int R;
int G;
int B;
void draw() {
  for (int s = 0; s < 1000; s++) {
    if (a < width*height) {
      errors[0] = 0.4375;
      errors[1] = 0.1875;
      errors[2] = 0.3125;
      errors[3] = 0.0625;
      if (red(pixels[a])>128) {
        errorred = red(pixels[a])-255;
        R = 255;
      } else {
        errorred = red(pixels[a]);
        R = 0;
      }

      if (green(pixels[a])>128) {
        errorgreen = green(pixels[a])-255;
        G = 255;
      } else {
        errorgreen = green(pixels[a]);
        G = 0;
      }

      if (blue(pixels[a])>128) {
        errorblue = blue(pixels[a])-255;
        B = 255;
      } else {
        errorblue = blue(pixels[a]);
        B = 0;
      }
      pixels[a] = color(R, G, B);
      if (indexX(a)==0) {
        errors[1] = 0;
      }
      if (indexX(a)==599) {
        errors[0] = 0;
        errors[3] = 0;
      }
      if (indexY(a)==599) {
        errors[1] = 0; 
        errors[2] = 0; 
        errors[3] = 0;
      }
      if (a+1<width*height) {
        pixels[a+1] = color(red(pixels[a+1])+round(errors[0]*errorred), green(pixels[a+1])+round(errors[0]*errorgreen), blue(pixels[a+1])+round(errors[0]*errorblue));
      }
      if (a+width-1<width*height) {
        pixels[a+width-1] = color(red(pixels[a+width-1])+round(errors[1]*errorred), green(pixels[a+width-1])+round(errors[1]*errorgreen), blue(pixels[a+width-1])+round(errors[1]*errorblue));
      }
      if (a+width<width*height) {
        pixels[a+width] = color(red(pixels[a+width])+round(errors[2]*errorred), green(pixels[a+width])+round(errors[2]*errorgreen), blue(pixels[a+width])+round(errors[2]*errorblue));
      }
      if (a+width+1<width*height) { 
        pixels[a+width+1] = color(red(pixels[a+width+1])+round(errors[3]*errorred), green(pixels[a+width+1])+round(errors[3]*errorgreen), blue(pixels[a+width+1])+round(errors[3]*errorblue));
      }
      a++;
      if (a == width*height) {
        noLoop();
        updatePixels();
        //exit();
      }
    }
  }
  updatePixels();
}

int indexX(int a) {
  return a%width;
}
int indexY(int a) {
  return ceil(a/width);
}
