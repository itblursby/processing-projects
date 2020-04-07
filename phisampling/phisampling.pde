int i = 0;
Sampler s = new Sampler();
void setup(){
  displayDensity(pixelDensity);
  colorMode(HSB,100);
  size(600,600);
  //frameRate(400);
}
void draw(){
  float f = s.nextSample()*100;
  fill(f,50,170);
  //noStroke();
  rect((i*20)%600,floor(i/30)*20,20,20);
  i++;
}
