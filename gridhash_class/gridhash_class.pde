import java.util.*; //<>//
GridHash<PVector> grid = new GridHash(20);
void setup() {
  size(600, 600);
}
void draw() {
  cursor(ARROW);
  cursor(HAND);
}
void mousePressed() {
  grid.put(new PVector(mouseX, mouseY), mouseX, mouseY);
  rect(20*floor(mouseX/20), 20*floor(mouseY/20), 20, 20);
  ellipse(grid.get(mouseX, mouseY).x, grid.get(mouseX, mouseY).y, 4, 4);
}
class GridHash <E> {
  private HashMap<PVector, E> hash = new HashMap();
  float size = 1;
  GridHash() {
  }
  GridHash(float si) {
    size = si;
  }
  E get(float x, float y) {
    int x_ = floor(x/size);
    int y_ = floor(y/size);
    println(hash.toString());

    if (hash.containsKey(new PVector(x_, y_))) {
      return hash.get(new PVector(x_, y_));
    }
    return null;
  }
  boolean hasKey(float x, float y) {
    int x_ = floor(x/size);
    int y_ = floor(y/size);
    if (hash.containsKey(new PVector(x_, y_))) {
      return true;
    }
    return false;
  }
  E put(E element, int x, int y) {
    int x_ = floor(x/size);
    int y_ = floor(y/size);
    println(x_);
    println(y_);
    println (element);

    hash.put(new PVector(x_, y_), element);

    return element;
  }
}
class Point implements Comparator<Point>, Comparable<Point>{
  int x;
  int y;
  Point (int x, int y) {
    this.x = x;
    this.y = y;
  }
  int compare(Point a, Point b){
    return abs((a.x-b.x)*(a.y-b.y));
  }
  boolean equals(Point a){
    return this.x == a.x&&this.y == a.y;
  }
  int compareTo(Point a){
    return abs(this.x-a.x)+abs(this.y-a.y);
  }
}
