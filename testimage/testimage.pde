void setup() {
  size(150, 150);
  loadPixels();
  for (int i = 0; i < 50; i++) {
    int j = 0;
    boolean col = false;
    for (int k = 0; k < i; k++) {
      pixels[(i+25)*width+(j+25)] = col ? color(255) : color(0);
      j++;
      col = !col;
    }
    for (int k = 0; k < 100 - 2*i; k++) {
      pixels[(i+25)*width+(j+25)] = col ? color(255) : color(0);
      j++;
    }
    for (int k = 0; k < i; k++) {
      col = !col;
      pixels[(i+25)*width+(j+25)] = col ? color(255) : color(0);
      j++;
    }
  }
  for (int i = 50; i < 100; i++) {
    int j = 0;
    boolean col = false;
    for (int k = 0; k < 99-i; k++) {

      pixels[(i+25)*width+(j+25)] = col ? color(255) : color(0);
      j++;
      col = !col;
    }
    for (int k = 0; k < 100-(198-2*i); k++) {
      pixels[(i+25)*width+(j+25)] = col ? color(255) : color(0);
      j++;
    }
    for (int k = 0; k < 99-i; k++) {
      col = !col;
      pixels[(i+25)*width+(j+25)] = col ? color(255) : color(0);
      j++;
    }
  }


  updatePixels();
  saveFrame();
}
void draw() {
}
