ArrayList<Circle> circles = new ArrayList<Circle>();
int max = 100;
void setup() {
  size(600, 600);
  pixelDensity(displayDensity());
  noStroke();
  frameRate(200);
  //stroke(255, 0, 0);
  //strokeWeight(0.5);
}
boolean black;
void draw() {

  float x = random(width);
  float y = random(height);
  float r = 0;
  boolean intersect = false;
  while (intersect == false) {
      black = true;

    for (Circle c : circles) {
      if (!intersect) {
        if (hasIntersection(new Circle(x, y, r, false), c)) {
          intersect = true;
        }
      }
    }
    if (x+r>width) {
      intersect = true;
      black = true;
    }
    if (x-r<0) {
      intersect = true;
      black = true;
    }
    if (y+r>height) {
      intersect = true;
      black = true;
    }
    if (y-r<0) {
      intersect = true;
      black = true;
    }
    r = r + 0.5;
    if (intersect) {
      r = r - 1;
    }
  }
  if (r > 1) {
    circles.add(new Circle(x, y, r, black));
    if (black) {
      fill(0);
    } else {
      fill(255);
    }
    fill(255,random(256),0);
    ellipse(x, y, r+r, r+r);
  }
  //print("done");
}
boolean hasIntersection(Circle a, Circle b) {
  if (!(a.x+a.r<b.x-b.r||a.x-a.r>b.x+b.r)) {
    if (!(a.y+a.r<b.y-b.r||a.y-a.r>b.y+b.r)) {
      float d = (a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y);
      if ((d<(a.r-b.r)*(a.r-b.r))) {
        black = !black;
        return false;
        
      } else if (d>(a.r+b.r)*(a.r+b.r)) {
        return false;
      } else {
        if (d < b.r*b.r){
          black = !black;
        }
        return true;
      }
    }
  }
  return false;
}
void keyPressed() {
  if (key == '0') {
    saveFrame();
  }
}
