int iterations = 100;

double creal; //C real value
double cimag; //C imaginary value
double zreal; //Z real value
double zimag; //Z imaginary value
double minreal; //lower left corner
double minimag;
double maxreal; //upper right corner
double maximag; 
double v = 40;
//double pixel = (maxreal-minreal)/width;
void setup() {
  size(100, 100);
  //colorMode(HSB, 100);

  minreal = -2;
  minimag = -2;
  if (width >= height) {
    maximag = 2;
    maxreal = (width/(double)height)*4-2;
  }
  if (height > width) {
    maxreal = 2;
    maximag = (height/(double)width)*4-2;
  }
  //pixel = (maxreal-minreal)/width;
  loadPixels();
  frameRate(30);
}
void draw() {

  //background(255);
  for (int a = 0; a < width*height; a++) {
    creal = minreal+(maxreal - minreal)*((a%width)/(double)width); //initializing C
    cimag = minimag+(maximag - minimag)*(1-(a/width)/(double)height);
    zreal = 0; //initializing Z
    zimag = 0;
    pixels[a] = color(0, 0, 0);
    for (int i = 0; i < iterations; i++) {
      double nreal = zreal*zreal-zimag*zimag;
      double nimag = 2*zreal*zimag;
      nreal += creal;
      nimag += cimag;
      zreal = nreal;
      zimag = nimag;
      if (zreal * zreal + zimag * zimag > 4) {
        pixels[a] = color((i&1)*255);//color(sin(i/40f)*200+55);
        //break;
      }
    }
  }
  updatePixels();
  if (mousePressed) {
    double[] temp = new double[2];
    temp[0] = ((mouseX-pmouseX)/(double)width)*(maxreal-minreal);
    temp[1] = ((mouseY-pmouseY)/(double)height)*(maximag-minimag);
    minreal -= temp[0];
    maxreal -= temp[0];
    minimag += temp[1];
    maximag += temp[1];
    //minreal -= (mouseX-pmouseX)*pixel;
    //maxreal -= (mouseX-pmouseX)*pixel;
    //minimag += (mouseY-pmouseY)*pixel;
    //maximag += (mouseY-pmouseY)*pixel;
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
void mouseWheel(MouseEvent e) {
  double mreal = (mouseX/(double)width)*(maxreal-minreal)+minreal;
  double mimag = (1-(mouseY/(double)height))*(maximag-minimag)+minimag;
  maxreal = (maxreal-mreal)*(1+e.getCount()/(double)v)+mreal;
  minreal = (minreal-mreal)*(1+e.getCount()/(double)v)+mreal;
  maximag = (maximag-mimag)*(1+e.getCount()/(double)v)+mimag;
  minimag = (minimag-mimag)*(1+e.getCount()/(double)v)+mimag;
}
