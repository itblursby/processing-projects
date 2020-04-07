class BestCandidate {
  int last = 4;
  int candids = 10;
  float min = 0;
  float max = 1;
  ArrayList<Float> samples = new ArrayList(0);
  BestCandidate(int last_, int q_, float min_, float max_) {
    last = last_;
    candids = q_;
    min = min_;
    max = max_;
  }
  BestCandidate(float min_, float max_) {
    min = min_;
    max = max_;
  }
  float nextSample(float min_, float max_) {
    float best = 0;
    float bestdist = -1;

    for (int i = 0; i < candids; i++) {
      float candidate = random(min_, max_);
      float cdist = 0;
      for (int j = 0; j < last; j++) {
        if (samples.size()-1-j > -1) {
          cdist += dis(candidate, samples.get(samples.size()-1-j));
        } else {
          break;
        }
      }
      if (cdist > bestdist){
        bestdist = new Float(cdist);
        best = new Float(candidate);
      }
    }
    samples.add(best);
    return best;
  }
  float dis(float a, float b) {
    return min(abs(a-b), abs((max-min)-abs(a-b)));
  }
}
