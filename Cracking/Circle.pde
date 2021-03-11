public class Circle {
  private float posx,posy;
  private float radius;
  private float angle;
  private PVector move;
  private float spin;
  private static final float mover = 3;
  private static final float spinr = 0.1;
  public Circle() {
    posx = random(width);
    posy = random(height);
    radius = random(min(width, height)/2.-1);
    move = new PVector(random(-mover, mover), random(-mover, mover));
    spin = random(-spinr, spinr);
  }
  public void update() {
    posx += move.x;
    posy += move.y;
    angle += spin;
  }
  public float getX() {
    return posx;
  }
  public float getY() {
    return posy;
  }
  public float getRad() {
    return radius;
  }
  public float getAngle() {
    return angle;
  }
}
