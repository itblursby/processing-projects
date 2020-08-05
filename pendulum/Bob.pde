class Bob {
  PVector pos;
  PVector ppos;
  PVector vel;
  //float mag;
  Bob(PVector p) {
    pos = p;
    ppos = p;
  }
  void move() {
    vel = PVector.sub(pos, ppos);
    vel.y += dt*dt*1f;
    ppos = pos;
    pos = PVector.add(pos,vel);
  }
  void constrain(Bob o){
    float dist = PVector.dist(o.pos,this.pos);
    PVector other = o.pos;
    pos = PVector.add(other,PVector.sub(pos,other).setMag(map(stiff,0,1,dist,LENGTH)));
  }
  void extend(){
    float dist = PVector.dist(ppos,pos);
    pos = PVector.add(ppos,PVector.sub(pos,ppos).setMag(map(stiff,0,1,dist,vel.mag())));
  }
  float getX() {
    return pos.x;
  }
  float getY() {
    return pos.y;
  }
}
