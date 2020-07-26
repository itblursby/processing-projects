//https://en.wikipedia.org/wiki/Descartes%27_theorem
DragCircle a;
DragCircle b;
DragCircle c;
void setup() {

  size(600, 600);
  //pixelDensity(displayDensity());
  a = new DragCircle((width/4)+random(width/2), (height/4)+random(height/2), 6);
  b = new DragCircle((width/4)+random(width/2), (height/4)+random(height/2), 6);
  c = new DragCircle((width/4)+random(width/2), (height/4)+random(height/2), 6);
  strokeWeight(1);
  stroke(255);
  noFill();
}
int max = 4;
int iterations = 6;
ArrayList<Circle[]> queue = new ArrayList(0);
void draw() {
  //colorMode(HSB, 100);
  background(0);


  a.move();
  b.move();
  c.move();
  float d1 = sqrt((a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y));
  float d2 = sqrt((b.x-c.x)*(b.x-c.x)+(b.y-c.y)*(b.y-c.y));
  float d3 = sqrt((c.x-a.x)*(c.x-a.x)+(c.y-a.y)*(c.y-a.y));
  float temp = (d1+d2+d3)/2;
  Circle i1 = new Circle(a.x, a.y, temp-d2);
  Circle i2 = new Circle(b.x, b.y, temp-d3);
  Circle i3 = new Circle(c.x, c.y, temp-d1);

  //TODO{
  queue = new ArrayList(0);
  queue.add(new Circle[] {i1, i2, i3});
  println(queue.size());
  //int test1 = 0;
  //while (queue.size()>0/*&&queue.size()<10000*/) {

  //  Circle[] todo = queue.get(0);
  //  Circle[] out = Descartes(todo[0], todo[1], todo[2]);

  //  if (todo.length == 3) {
  //    if (abs(out[0].getRadius())>max&&out[0].isOnScreen()) {
  //      queue.add(new Circle[] {todo[0], todo[1], out[0], todo[2]});
  //      queue.add(new Circle[] {todo[1], todo[2], out[0], todo[0]});
  //      queue.add(new Circle[] {todo[2], todo[0], out[0], todo[1]});
  //    }
  //    if (abs(out[1].getRadius())>max&&out[1].isOnScreen()) {
  //      queue.add(new Circle[] {todo[0], todo[1], out[1], todo[2]});
  //      queue.add(new Circle[] {todo[1], todo[2], out[1], todo[0]});
  //      queue.add(new Circle[] {todo[2], todo[0], out[1], todo[1]});
  //    }
  //    out[0].display();
  //    out[1].display();
  //  } else {

  //    Circle d = dif(out[0], out[1], todo[3]);
  //    d.display();
  //    if (abs(d.getRadius()) > max&&d.isOnScreen()) {
  //      queue.add(new Circle[] {todo[0], todo[1], d, todo[2]});
  //      queue.add(new Circle[] {todo[1], todo[2], d, todo[0]});
  //      queue.add(new Circle[] {todo[2], todo[0], d, todo[1]});
  //    }
  //  }

  //  queue.remove(0);
  //}
  stroke(255);
  Apollonian(i1, i2, i3);
  //fill(0,100,100);

  i1.display();
  i2.display();
  i3.display();



  noStroke();
  fill(255, 0, 0);
  a.show();
  fill(0, 255, 0);
  b.show();
  fill(0, 0, 255);
  c.show();
  noFill();
}
void Apollonian (Circle a, Circle b, Circle c) {
  Circle j = new Circle(0, 0, 0);
  Apollonianh(a, b, c, true, j, 0);
}
void Apollonianh (Circle a, Circle b, Circle c, boolean init, Circle d, int it) {
  if (it < iterations) {
    //fill(it*10+10, 100, 100);
    Circle[] M = Descartes(a, b, c);

    if (init) {
      if (M[0].isOnScreen()) {
        M[0].display();
      }
      if (M[1].isOnScreen()) {
        M[1].display();
      }
      if (abs(M[0].getRadius())>max) {
        Apollonianh(a, b, M[0], false, c, it+1);
        Apollonianh(b, c, M[0], false, a, it+1);
        Apollonianh(c, a, M[0], false, b, it+1);
      }
      if (abs(M[1].getRadius())>max) {
        Apollonianh(a, b, M[1], false, c, it+1);
        Apollonianh(b, c, M[1], false, a, it+1);
        Apollonianh(c, a, M[1], false, b, it+1);
      }
    } else {
      Circle h = dif(M[0], M[1], d);
      h.display();
      if (abs(h.getRadius())>max) {
        Apollonianh(a, b, h, false, c, it+1);
        Apollonianh(b, c, h, false, a, it+1);
        Apollonianh(c, a, h, false, b, it+1);
      }
    }
  }
}

Circle dif(Circle a, Circle b, Circle c) {
  if (dist2(a.getLocation(), c.getLocation())>dist2(b.getLocation(), c.getLocation())) {
    return a;
  }
  return b;
}
//Method that finds a common intersection between three Circles,
//given that they already have a common intersection.
PVector ComIntersect(Circle a, Circle b, Circle c) {
  PVector[] i = a.Intersections(b);
  if (abs(dist2(i[0], c.getLocation())-abs(c.getRadius()))>abs(dist2(i[1], c.getLocation())-abs(c.getRadius()))) {
    return i[1];
  }
  return i[0];
}
//CODING DESCARTES THEOREM TOOK ME LIKE 5 HOURS AAAHHHHHH
Circle[] Descartes(Circle a, Circle b, Circle c) {

  float[] nr = newRadius(a, b, c);
  Circle[] newc = new Circle[2];
  newc[0] = new Circle(ComIntersect(a.a(nr[0]), b.a(nr[0]), c.a(nr[0])), nr[0]);
  newc[1] = new Circle(ComIntersect(a.a(nr[1]), b.a(nr[1]), c.a(nr[1])), nr[1]);
  return newc;
}
//distance between two PVectors
//only x and y
float dist2(PVector a, PVector b) {
  return sqrt((a.x-b.x)*(a.x-b.x)+(a.y-b.y)*(a.y-b.y));
}
float[] newRadius(Circle a, Circle b, Circle c) {
  float[] newr = new float[2];
  float k1 = a.getCurve();
  float k2 = b.getCurve();
  float k3 = c.getCurve();
  float t1 = k1+k2+k3;
  float t2 = 2*sqrt(k1*k2+k2*k3+k3*k1);
  newr[0] = 1/(t1+t2);
  newr[1] = 1/(t1-t2);
  return newr;
}
