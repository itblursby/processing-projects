class Circle {
  float x;
  float y;
  float nx;
  float ny;
  float px;
  float py;
  float d;
  color col;
  Circle(float x_, float y_, float d_) {
    x = x_;
    y = y_;
    px = x_;
    py = y_;
    nx = x_;
    ny = y_;
    d = d_;
    col = color(64+random(128),64+random(128),64+random(128));
  }
  void set_center(float x_, float y_) {//test
    x = (x_);
    y = (y_);
  }
  void set_new_center(float x_, float y_) {
    nx = (x_);
    ny = (y_);
  }
  void iterate() {
    px = x;
    py = y;
    x = nx;
    y = ny;
  }
  void move() {
    
    set_new_center(2*x-px+(x-width/2)/-dis(x,y,width/2,height/2),2*y-py+(y-height/2)/-dis(x,y,width/2,height/2));
    //set_new_center(2*x-px,2*y-py+1);
    

}

  void display() {
   fill(col);
   noStroke();
    ellipse(x, y, d, d);
  }
}
