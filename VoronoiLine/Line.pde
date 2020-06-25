class Line {
  float a;
  float b;
  float c;
  PVector p1;
  PVector p2;
  //float rand = -1;
  color col = color(random(100,256),random(100,256),random(100,256));
  Line(float a_, float b_, float c_) {
    a = a_;
    b = b_;
    c = c_;
    p1 = new PVector(-c/a, 0);
    p2 = new PVector(-c/b, 0);
  }
  Line(PVector p1_, PVector p2_) {
    p1 = p1_;
    p2 = p2_;
    a = p1.y-p2.y;
    b = p2.x-p1.x;
    c = (p2.y*p1.x)-(p2.x*p1.y);
  }
  float distToPoint(PVector p){
    return (abs(a*p.x+b*p.y+c)/sqrt(a*a+b*b));
  }
  void display(){
    
    line(0,(-c/b)/2,width,((-c-a*pixelWidth)/b)/2);
  }
}
