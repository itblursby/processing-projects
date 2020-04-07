class Poisson {
  GridHash<Integer> grid = new GridHash();

  ArrayList<Integer> active = new ArrayList(0);
  ArrayList<PVector> samples = new ArrayList(0);
  float r = 10;
  int k = 30;
  boolean initial = true;
  PVector init;
  Poisson(float x1, float y1, float r_, int k_) {
    this.r = r_;
    this.k = k_;
    this.init = new PVector(x1, y1);
    this.k = k_;
    addSample(init);
  }
  Poisson(float x1, float y1, float r_) {
    this.init = new PVector(x1, y1);
    this.r = r_;
    addSample(init);
  }
  PVector nextSample() {
    if (initial) {
      initial = false;
      return init;
    }
    //boolean found = false;
    while (true) {
      int samplei = floor(random(active.size()));
      PVector sample = samples.get(active.get(samplei));
      for (int i = 0; i < k; i++) {
        float angle = random(TAU);
        PVector candidate = new PVector(sample.x+cos(angle)*(r+random(r)), sample.y+sin(angle)*(r+random(r)));
        if (check(candidate)) {
          addSample(candidate);
          return candidate;
        }
      }
      active.remove(samplei);
    }
    //return new PVector(0,0);
  }
  private void addSample(PVector q) {
    samples.add(q);
    active.add(samples.size()-1);
    int x = floor(q.x/(this.r/sqrt(2)));
    int y = floor(q.y/(this.r/sqrt(2)));

    grid.put(samples.size()-1, x, y);
  }
  private boolean check(PVector n) {
    boolean good = true;
    int x = floor(n.x/(r/sqrt(2)));
    int y = floor(n.y/(r/sqrt(2)));

    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        if (grid.hasKey(x+i, y+j)) {
          PVector d = samples.get(grid.get(x+i, y+j));
          if ((d.x-n.x)*(d.x-n.x)+(d.y-n.y)*(d.y-n.y)<r*r) {
            good = false;
          }
        }
      }
    }
    //for (PVector s : samples) {
    //  if (!(s.x+r<i.x-r||s.x-r>i.x+r)) {
    //    if (!(s.y+r<i.y-r||s.y-r>i.y+r)) {
    //      if ((s.x-i.x)*(s.x-i.x)+(s.y-i.y)*(s.y-i.y)<r*r) {
    //        good = false;
    //      }
    //    }
    //  }
    //}
    return good;
  }
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
    

    hash.put(new PVector(x_, y_), element);

    return element;
  }
}
