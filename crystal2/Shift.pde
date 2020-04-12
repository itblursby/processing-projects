class Shift {
  //position, range, set, vertical or horizontal
  int pos;
  int ran;
  int off;
  boolean hor;
  Shift(int position, int range, int offset_, boolean isHorizontal) {
    pos = position; 
    ran = range;
    off = offset_;
    hor = isHorizontal;
  }
  int[] getNew(int x, int y) {
    int s;
    if (hor) {
      s = y-pos;
      s = mod(s, height);
      if (s < ran) {
        return new int[] {mod(x+off, width), y};
      }
    } else {
      s = x-pos;
      s = mod(s, width);
      if (s < ran) {
        return new int[] {x, mod(y+off, height)};
      }
    }
    return new int[] {x, y};
  }
  int mod(int a, int b) {
    return (a % b + b) % b;
  }
}
