public class Turn {
  private float x;
  private float y;
  private float radsq;
  private float sine;
  private float cosine;
  Turn(float x_, float y_, float rad, float a) {
    x = x_;
    y = y_;
    radsq = rad*rad;
    sine = sin(a);
    cosine = cos(a);
  }
  public void setPos(float x_, float y_) {
    x = x_;
    y = y_;
    //radsq = rad*rad;
    //sine = sin(a);
    //cosine = cos(a);
  }
  public void setAngle(float a){
    sine = sin(a);
    cosine = cos(a);
  }
  public void change(PVector p) {
    float dx = p.x - x;
    float dy = p.y - y;
    if (dx > realwidth/2) {
      dx -= realwidth;
    } else if (dx < -realwidth/2) {
      dx += realwidth;
    }
    if (dy > realheight/2) {
      dy -= realheight;
    } else if (dy < -realheight/2) {
      dy += realheight;
    }
    if (dx*dx+dy*dy < radsq) {
      p.set(x+dx*cosine-dy*sine, y+dx*sine+dy*cosine);
      p.x = (p.x+realwidth)%realwidth;
      p.y = (p.y+realheight)%realheight;
    }
  }
}
