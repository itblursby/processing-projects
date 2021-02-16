public class Shift {

  private float pos;
  private float breadth;
  private float shift;
  private boolean orientation;
  private float move;
  private float shiftchange;
  public Shift(int move) {
    if (random(1)>0.5) {
      orientation = false;
      pos = random(width);
      breadth = random(width);
      shift = random(height);
    } else {
      orientation = true;
      pos = random(height);
      breadth = random(height);
      shift = random(width);
    }
    //breadth = 40;
    shiftchange = random(-move, move);
    this.move = random(-move, move);
  }  
  public float getPos1() {
    return pos;
  }
  public float getPos2() {
    int s = orientation?height:width;
    return (pos + breadth + s) % s;
  }
  public boolean getOrientation() {
    return orientation;
  }
  public float getShift() {
    return shift;
  }
  public void update() {
   
    pos += move;
    shift += shiftchange;
    //shift *= 0.99;
    if (orientation) {
      pos = (pos + height) % height;
      shift = (shift + width) % width;
    } else {
      pos = (pos + width) % width;
      shift = (shift + height) % height;
    }
  }
}
