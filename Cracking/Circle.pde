public class Circle {
  private PVector pos;
  private float radius;
  private float angle;
  private PVector move;
  private float spin;
  private static final float mover = 1;
  private static final float spinr = 0.005;
  public Circle() {
    pos = new PVector(random(width), random(height));
    //posy = random(height);
    radius = random(min(width, height)/2.-1);
    move = new PVector(random(-mover, mover), random(-mover, mover));
    spin = random(-spinr, spinr);
    
  }
  public void update() {
    pos.x += move.x;
    pos.y += move.y;
    pos.x = (pos.x+width)%width;
    pos.y = (pos.y+height)%height;
    angle += spin;
  }
  public float getX() {
    return pos.x;
  }
  public float getY() {
    return pos.y;
  }
  public float getRad() {
    return radius;
  }
  public float getAngle() {
    return angle;
  }
  public void display() {
    ellipse(pos.x,pos.y,radius*2,radius*2);
  }
}
