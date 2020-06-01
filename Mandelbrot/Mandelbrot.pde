float creal; //C real value
float cimag; //C imaginary value
float zreal; //Z real value
float zimag; //Z imaginary value
float minreal; //lower left corner
float minimag;
float maxreal; //upper right corner
float maximag; 
float pixel = (maxreal-minreal)/width;
void setup() {
  size(300, 500);
  //colorMode(HSB, 100);
  
  minreal = -2;
  minimag = -2;
  if (width > height) {
    maximag = 2;
    maxreal = (width/(float)height)*4-2;
    
  }
  if (height > width) {
    maxreal = 2;
    maximag = (height/(float)width)*4-2;
  }
  
  pixel = (maxreal-minreal)/width;
  loadPixels();
  frameRate(30);
}
void draw() {

  //background(255);
  for (int a = 0; a < width*height; a++) {
    creal = minreal+(maxreal - minreal)*((a%width)/(float)width); //initializing C
    cimag = minimag+(maximag - minimag)*((a/width)/(float)height);
    zreal = 0; //initializing Z
    zimag = 0;
    pixels[a] = color(0, 0, 0);
    for (int i = 0; i < 200; i++) {
      float nreal = zreal*zreal-zimag*zimag;
      float nimag = 2*zreal*zimag;
      nreal += creal;
      nimag += cimag;
      zreal = nreal;
      zimag = nimag;
      if (zreal * zreal + zimag * zimag > 4) {
        pixels[a] = color(255);
        break;
      }
    }
    
  }
  updatePixels();
  if (mousePressed){
    minreal -= (mouseX-pmouseX)*pixel;
    maxreal -= (mouseX-pmouseX)*pixel;
    minimag -= (mouseY-pmouseY)*pixel;
    maximag -= (mouseY-pmouseY)*pixel;
  }
  //if (keyPressed) {
  //  increal = (maxreal-minreal)/150;
  //  incimag = (maximag-minimag)/150;
  //  if (key == 'w' || key == 'W') {
  //    minimag -= incimag;
  //    maximag -= incimag;
  //  }
  //  if (key == 's' || key == 'S') {
  //    minimag += incimag;
  //    maximag += incimag;
  //  }
  //  if (key == 'a' || key == 'A') {
  //    minreal += increal;
  //    maxreal += increal;
  //  }
  //  if (key == 'd' || key == 'D') {
  //    minreal -= increal;
  //    maxreal -= increal;
  //  }
  //}
}
