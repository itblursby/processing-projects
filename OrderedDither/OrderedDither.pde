import java.util.Arrays;
int i = 0;
int w = 256;
void setup() {
  size(256, 256);
  int[] grid = new int[w*w];
  fillGrid(0, 0, w, 1, 0, grid, w);
  print(Arrays.toString(grid));
  loadPixels();
  for (int i = 0; i < w*w; i++){
    pixels[i] = color(256./(w*w)*grid[i]);
  }
  updatePixels();
  saveFrame();
}
void fillGrid(int x, int y, int w, int m, int u, int[] grid, int gwidth) {
  if (w == 2) {
    grid[x+y*gwidth] = u;
    grid[x+1+(y+1)*gwidth] = u+m;
    grid[x+1+(y)*gwidth] = u+2*m;
    grid[x+(y+1)*gwidth] = u+3*m;
  } else {
    fillGrid(x, y, w/2, m*4, u, grid, gwidth);
    fillGrid(x + w/2, y + w/2, w/2, m*4, u+m, grid, gwidth);
    fillGrid(x + w/2, y, w/2, m*4, u+2*m, grid, gwidth);
    fillGrid(x, y + w/2, w/2, m*4, u+3*m, grid, gwidth);
  }
}
