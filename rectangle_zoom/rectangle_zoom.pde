float min = 1;
float mincut = 0.01;
float maxcut = 0.99;
float zoom = 1.02;

float temp;
Rectangle middle; 
ArrayList<Rectangle> rects = new ArrayList<Rectangle>(0);
void setup() {
  rectMode(CORNERS);
  size(800, 800);
  middle = new Rectangle(-width/2, -height/2, width/2, height/2);
}

void draw() {
  background(255);
  
  translate(width/2, height/2);
  //rotate(frameCount/20.);
  rectMode(CORNERS);
  while (middle.getWidth() > min || middle.getHeight() > min) {
    temp = random(mincut, maxcut);
    if (middle.getWidth()>=middle.getHeight()) {
      temp = middle.x1 + temp*(middle.x2 - middle.x1);
      if (0 < temp) {
        rects.add(new Rectangle(temp, -height/2, width/2, height/2));
        middle.set(middle.x1, middle.y1, temp, middle.y2);
      } else {
        rects.add(new Rectangle(-width/2, -height/2, temp, height/2));
        middle.set(temp, middle.y1, middle.x2, middle.y2);
      }
    } else {
      temp = middle.y1 + temp*(middle.y2 - middle.y1);
      if (0 < temp) {
        rects.add(new Rectangle(-width/2, temp, width/2, height/2));
        middle.set(middle.x1, middle.y1, middle.x2, temp);
      } else {
        rects.add(new Rectangle(-width/2, -height/2, width/2, temp));
        middle.set(middle.x1, temp, middle.x2, middle.y2);
      }
    }
  }
  middle.scale(zoom);
  for (int i = rects.size()-1; i > -1; i--) {
    if (rects.get(i).onscreen()) {
      rects.get(i).scale(zoom);
    } else {
      rects.remove(i);
    }
  }
  for (int i = rects.size()-1; i > -1; i--) {
    rects.get(i).display();
  }
}
