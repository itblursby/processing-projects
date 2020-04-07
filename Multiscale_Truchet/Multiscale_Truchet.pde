//Based on this paper
//https://christophercarlson.com/portfolio/multi-scale-truchet-patterns/
ArrayList<float[]> queue = new ArrayList(0);
float init = 100;
color a = color(255);
color b = color(0);
int iterations = 3;
float last = init;
PImage img;
void setup() {
  img = loadImage("doge.png");
  for (int i = 0; i < iterations; i++) {
    last = last/2;
  }
  print(last);
  
  frameRate(200);

  background(0);
  pixelDensity(displayDensity());
  noStroke();
  size(600, 600);

  for (int i = 0; i < ceil(width/init); i++) {
    for (int j = 0; j < ceil(height/init); j++) {
      queue.add(new float[]{i*init, j*init, init, 1});
    }
  }
}
void draw() {
  if (queue.size()>0) {
    if (random(1)<0.5) {
      s(queue.get(0)[0], queue.get(0)[1], queue.get(0)[2], queue.get(0)[3]);
      queue.remove(0);
    } else {
      if (queue.get(0)[2] > last) {
        float[] c = queue.get(0);
        queue.remove(0);
        queue.add(new float[]{c[0], c[1], c[2]/2, (c[3]+1)%2});
        queue.add(new float[]{c[0]+c[2]/2, c[1], c[2]/2, (c[3]+1)%2});
        queue.add(new float[]{c[0], c[1]+c[2]/2, c[2]/2, (c[3]+1)%2});
        queue.add(new float[]{c[0]+c[2]/2, c[1]+c[2]/2, c[2]/2, (c[3]+1)%2});
      } else {
        s(queue.get(0)[0], queue.get(0)[1], queue.get(0)[2], queue.get(0)[3]);
        queue.remove(0);
      }
    }
  } else {
    //blendMode(DARKEST);
    //image(img,0,0,width,height);
    
    
    noLoop();
  }
}
void s(float x, float y, float l, float d) {
  noStroke();
  if (d == 0) {
    fill(b);
  } else {
    fill(a);
  }

  square(x, y, l);
  circle(x, y, 2*l/3);
  circle(x+l, y, 2*l/3);
  circle(x, y+l, 2*l/3);
  circle(x+l, y+l, 2*l/3);

  noFill();
  strokeWeight(l/3);
  if (d == 0) {
    stroke(a);
  } else {
    stroke(b);
  }
  if (random(1)>0.5) {
    arc(x+l, y, l, l, PI/2, PI);
    arc(x, y+l, l, l, PI+PI/2, PI+PI);
  } else {
    arc(x, y, l, l, 0, PI/2);
    arc(x+l, y+l, l, l, PI, PI+PI/2);
  }
}
void keyPressed() {
  if (key == 'p') {
    saveFrame();
  }
}
