PShader test1;
void setup(){
  test1 = loadShader("testfrag.glsl");
  size(600,600,P2D);
}
void draw(){
  shader(test1);
  rect(0,0,600,600);
}
