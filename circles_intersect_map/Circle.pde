class Circle{
  float x = 0;
  float y = 0;
  float xvel = 0;
  float yvel = 0;
  float r = 10;
  float c = 0;
  Circle(float x_, float y_, float r_,float d, float speed,float c_){
     this.x = x_;
     this.y = y_;
     this.xvel = cos(d)*speed;
     this.yvel = sin(d)*speed;
     this.r = r_;
     this.c = c_;
  }
  void move(){
    x = x + xvel;
    y = y + yvel;
    if (x - r > width) {
      x = -r;
    }else if(x + r < 0) {
      x = width+r;
    }
    if (y - r > height) {
      y = -r;
    }else if (y + r < 0){
      y = height + r;
    }
  }
  void show(){//test only

    ellipse(x,y,r*2,r*2);
  }
}
