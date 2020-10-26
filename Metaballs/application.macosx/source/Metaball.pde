class Metaball {
  PVector pos;
  PVector vel;
  float radius;
  float radius2;
  Metaball() {
    pos = new PVector(random(0, width), random(0, height));
    float dir = random(0, TAU);
    float speed = random(3, 5);
    vel = new PVector(cos(dir)*speed, sin(dir)*speed);
    radius = random(minsize, maxsize);
    radius2 = radius * radius;
  }
  void move() {
    pos.add(vel);
    if (pos.x+radius>width||pos.x-radius<0) {
      pos.x = constrain(pos.x,radius,width-radius);
      vel.x = -vel.x;
      
    }
    if (pos.y+radius>height||pos.y-radius<0) {
      pos.y = constrain(pos.y,radius,height-radius);
      vel.y = -vel.y;
    }
  }
  float inf(PVector a){
    return radius2/((a.x-pos.x)*(a.x-pos.x)+(a.y-pos.y)*(a.y-pos.y));
  }
  void display(){
    ellipse(pos.x,pos.y,radius+radius,radius+radius);
  }
}
