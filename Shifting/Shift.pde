public class Shift {

  private float pos;
  private float breadth;
  private float shift;
  final private boolean orientation;
  private float move;
  private float shiftchange;
  private boolean dir;
  private float colchange;

  public Shift(float move) {
    dir = random(1) > 0.5;
    if (random(1)>0.5) {
      orientation = false;
      pos = random(width);
      breadth = random(width);
      //breadth = 5;
      shift = random(-height, height);
    } else {
      orientation = true;
      pos = random(height);
      breadth = random(height);
      //breadth = height/2;
      shift = random(-width, width);
    }
    colchange = random(1);
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
  public float getCol(){
    return colchange;
  }
  public void update() {
    pos += move;
    //shift += shiftchange *sin(frameCount/100.);
    shift += shiftchange;
    //breadth *= 0.99;
    //wane();
    if (orientation) {
      pos = (pos + height) % height;
      shift = (shift + width) % width;
    } else {
      pos = (pos + width) % width;
      shift = (shift + height) % height;
    }
  }
  private void wane() {
    
    //move *= 1.01;
    if (dir) {
      shift *= 0.99;
    } else {
      int s = orientation?width:height;
      shift = s-(0.99*(s-shift));
    }
  }
}
