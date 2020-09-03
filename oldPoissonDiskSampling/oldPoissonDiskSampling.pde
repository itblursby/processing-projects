int size = 20;
void setup() {
  size(600, 600);
  background(255);
  //for (int i = 0; i < width/size; i++) {
  //  line(i*size, 0, i*size, height);
  //}
  //for (int i = 0; i < height/size; i++) {
  //  line(0, i*size, width, i*size);
  //}
  
  strokeWeight(3);
  stroke(255,0,0);
  pixelDensity(displayDensity());
  
  //frameRate(1);
  //noStroke();
}
Poisson p = new Poisson(300, 300, size);
void draw() {
 
  for (int i =0; i < 200; i++) {
    PVector j = p.nextSample();
    //fill(random(255), 0, random(255));
    point(j.x, j.y);
  }
  //println(p.active);
}
/*
ArrayList<Integer> active = new ArrayList(0);
 ArrayList<PVector> samples = new ArrayList(0);
 ArrayList<PVector> grid = new ArrayList(0);
 int r = 30; //minimum distance between samples
 int k = 30; //
 float cellsize = r/sqrt(2);
 
 void setup() {
 size(900, 900);
 pixelDensity(2);
 fill(0, 255, 0);
 
 
 background(255, 255, 255);
 addActive(new PVector(width/2, height/2));
 frameRate(2);
 }
 
 void draw() {
 if (active.size() > 0) {
 
 check();
 }
 
 }
 
 //puts samples into cells to speed up
 //distance detection
 PVector cell(PVector j) {
 return new PVector(floor(j.x/cellsize), floor(j.y/cellsize));
 }
 void addActive(PVector s) {
 active.add(samples.size());
 samples.add(s);
 grid.add(cell(s));
 circle(s.x, s.y, r/2);
 }
 void check() {
 boolean added = false;
 while (!added) {
 int s = floor(random(active.size()));
 PVector sample = samples.get(active.get(s));
 PVector candidate;
 boolean stillActive = false;
 
 for (int i = 0; i < k; i++) {
 float a = random(TAU);
 candidate = new PVector(sample.x+cos(a)*(r+random(r)), sample.y+sin(a)*(r+random(r)));
 PVector cell = cell(candidate);
 boolean found2 = true;
 for (int j = 0; j < samples.size(); j++) {
 if (abs(grid.get(j).x-cell.x) < 4) {
 if (abs(grid.get(j).y-cell.y) < 4) {
 if ((samples.get(j).x-candidate.x)*(samples.get(j).x-candidate.x)
 +(samples.get(j).y-candidate.y)*(samples.get(j).y-candidate.y)<r*r) {
 found2 = false;
 break;
 }
 }
 }
 }
 if (found2) {
 addActive(candidate);
 added = true;
 //line(candidate.x, candidate.y, samples.get(active.get(s)).x, samples.get(active.get(s)).y);
 stillActive = true;
 break;
 }
 }
 if (!stillActive) {
 active.remove(s);
 }
 }
 }
 */
