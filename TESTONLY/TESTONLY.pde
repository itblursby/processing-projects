void setup(){
  size(600,600);
  fill(0);
}

float a = 300;
float mouse = 0;
void draw(){
  background(255);
  ellipse(300,300,a,a);
  text(mouse,10,30);
}
void mouseWheel(MouseEvent e){
  a-= e.getCount();
  textSize(20);
  mouse = e.getCount();
}
