void setup() {
  size(600, 600);
  //pixelDensity(displayDensity());
  pixelDensity(1);
  noStroke();
}

float a = 0;

int iterations = 7;

float last = 600*pow(0.5, iterations);
float r = 2;
void draw() {
  background(0);
  a += 0.002;
  halfcirc(300, 300, 600, a);

 
}
void halfcirc(float x, float y, float diameter, float d) {
  fill(255);
  arc(x, y, diameter, diameter, d, d+PI, PIE);
  fill(0);
  arc(x, y, diameter, diameter, d+PI, d+TWO_PI, PIE);
  if (diameter>last) {
    halfcirc(x+cos(d)*diameter/4, y+sin(d)*diameter/4, diameter/2, r*d);
    halfcirc(x-cos(d)*diameter/4, y-sin(d)*diameter/4, diameter/2, r*d);
  } else {
    
    //fill(255);
    //circle(x-cos(d)*diameter/4, y-sin(d)*diameter/4, diameter/2);
    //fill(0);
    //circle(x+cos(d)*diameter/4, y+sin(d)*diameter/4, diameter/2);
    //circle(x-cos(d)*diameter/4, y-sin(d)*diameter/4, diameter/4);
    //fill(255);
    //circle(x+cos(d)*diameter/4, y+sin(d)*diameter/4, diameter/4);
  }
}
