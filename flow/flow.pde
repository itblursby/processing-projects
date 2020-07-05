Point[] points = new Point[200];
float m = 200;
float d = 1;
float sc = 200;
void setup() {
  for (int i = 0; i < points.length; i++) {
    points[i] = new Point(new PVector(random(0, height), random(0, height)));
  }
  background(255);
  pixelDensity(displayDensity());
  size(600, 600);
  //noStroke();

  noiseDetail(1, 0.5);
  loadPixels();
  // colorMode(RGB, 255);
  //for (int x = 0; x < pixelWidth; x++) {
  //  for (int y = 0; y < pixelHeight; y++) {
  //    pixels[x+y*pixelWidth] = color(noise(x/2/sc, y/2/sc)*255);
  //  }
  //}
  strokeWeight(1);
  updatePixels();
}
void draw() {

  strokeWeight(((sin(frameCount/10.0)+1)/2)*3);
  for (int i = 0; i < points.length; i++) {
    float s;
    s = m*noise(points[i].pos.x/sc, points[i].pos.y/sc);

    //s+=(i/(float)points.length)*PI;
    //colorMode(HSB,100);
    //stroke(i/(float)points.length*255);
    stroke(0);
    if (i/(float)points.length<0.5) {
      s+=PI;
      stroke(255, 0, 0);
    }
    line(points[i].pos.x, points[i].pos.y, points[i].pos.x+cos(s)*d, points[i].pos.y + sin(s)*d);
    points[i].pos.add(cos(s)*d, sin(s)*d);
    if (points[i].pos.x > width||points[i].pos.x < 0) {
      points[i].pos = new PVector(random(0, width), random(0, height));
    } else if (points[i].pos.y > height||points[i].pos.y < 0) {
      points[i].pos = new PVector(random(0, width), random(0, height));
    }
  }
  //line(x, y, x+cos(s)*10, y + sin(s)*10);
  //pixels[x+y*width] = color(255*noise((x+frameCount)/100.0,y/100.0));

  //updatePixels();
}
void keyPressed() {
}
