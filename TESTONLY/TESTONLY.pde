BestCandidate s = new BestCandidate(0, 100);
void setup() {
  size(100, 600);
  pixelDensity(displayDensity());
}
int a = 0;
void draw() {

  a++;
  line(0, a*5, 100, a*5);
  ellipse(s.nextSample(0, 100), a*5, 5, 5);
}
