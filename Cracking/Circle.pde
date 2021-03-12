public class Circle {
  private PVector pos;
  private float radius;
  private float angle;
  private PVector move;
  private float spin;
  private static final float mover = 3;
  private static final float spinr = 0.1;
  public Circle() {
    pos = new PVector(random(width),random(height));
    //posy = random(height);
    radius = random(min(width, height)/2.-1);
    move = new PVector(random(-mover, mover), random(-mover, mover));
    spin = random(-spinr, spinr);
  }
  public void update() {
    pos.x += move.x;
    pos.y += move.y;
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
}
