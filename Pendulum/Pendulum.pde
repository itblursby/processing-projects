final float LENGTH = 100;
final PVector gravity = new PVector(0f, 1f);
final float stiff = 0.1f;
final float dt = 1;
Bob[] bobs = new Bob[3];

void setup() {

  size(800, 800);
  bobs[0] = new Bob(new PVector(0f, 0f));
  for (int i = 1; i < bobs.length; i++) {
    float rand = random(TAU);
    bobs[i] = new Bob(new PVector(bobs[i-1].getX()+cos(rand)*100,bobs[i-1].getY()+sin(rand)*100));
  }
  //bobs[1] = new Bob(new PVector(100f, 0f));
  //bobs[2] = new Bob(new PVector(200f, 0f));
  //bobs[3] = new Bob(new PVector(300f, 0f));
  //bobs[4] = new Bob(new PVector(400f, 0f));

  fill(0, 255, 0);
  stroke(0);
}
void draw() {
  background(255);
  translate(width/2, height/2);
  for (int i = 0; i < bobs.length; i++) {
    if (i < bobs.length-1) {
      line(bobs[i].getX(), bobs[i].getY(), bobs[i+1].getX(), bobs[i+1].getY());
    }
    ellipse(bobs[i].getX(), bobs[i].getY(), 20, 20);
  }

  for (int i = 1; i < bobs.length; i++) {
    bobs[i].move();
  }
  //bobs[0].pos.x = mouseX-width/2;
  //bobs[0].pos.y = mouseY-height/2;

  for (int j = 0; j < 40; j++) {
    for (int i = 1; i < bobs.length; i++) {
      bobs[i].constrain(bobs[i-1]);
      if (i < bobs.length-1) {
        bobs[i].constrain(bobs[i+1]);
      }
      bobs[i].extend();
    }
  }
}
