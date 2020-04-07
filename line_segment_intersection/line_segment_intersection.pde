DragCircle a1 = new DragCircle(200, 200,5);
DragCircle a2 = new DragCircle(400, 400,5);
DragCircle b1 = new DragCircle(200, 400,5);
DragCircle b2 = new DragCircle(400, 200,5);

void setup() {
  pixelDensity(displayDensity());
  size(600, 600);
}
void draw() {
  background(255);
  noFill();
  if (intersect(a1.getX(),a1.getY(),a2.getX(),a2.getY(),b1.getX(),b1.getY(),b2.getX(),b2.getY())){
    fill(255,0,0);
  }
  a1.move();
  a1.display();
  a2.move();
  a2.display();
  b1.move();
  b1.display();
  b2.move();
  b2.display();
  line(a1.getX(),a1.getY(),a2.getX(),a2.getY());
  line(b1.getX(),b1.getY(),b2.getX(),b2.getY());
  
}


boolean intersect(float x1,float y1,float x2,float y2,float x3,float y3,float x4,float y4){
  if (!(isLeft(x1,y1,x2,y2,x3,y3)^isLeft(x1,y1,x2,y2,x4,y4))){
    return false;
  }
  if (!(isLeft(x3,y3,x4,y4,x1,y1)^isLeft(x3,y3,x4,y4,x2,y2))){
    return false;
  }
  return true;

}
boolean isLeft(float x1,float y1,float x2,float y2,float xt,float yt){
  if ((y1-y2)*xt-(x1-x2)*yt>(-y2)*x1-(-x2)*y1){
    return true;
  }
  return false;
  
}
