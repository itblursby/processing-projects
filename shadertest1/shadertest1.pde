PShader test1;
void setup(){
  test1 = loadShader("testfrag.glsl");
  size(600,600,P2D);
  shader(test1);
}
void draw(){
  background(0);
  
  rect(0,0,600,600);
}
