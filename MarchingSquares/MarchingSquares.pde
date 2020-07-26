// tutorial: http://jamie-wong.com/2014/08/19/metaballs-and-marching-squares/

final int cw = 2;
final float scale = 50f;
final float threshold = 0.5;
boolean[][] squares = new boolean[16][6];

void setup() {
  noiseDetail(1,1);
  size(600, 600);
  squares[0] = new boolean[] {false, false, false, false, false, false};
  squares[1] = new boolean[] {true, false, false, false, false, false};
  squares[2] = new boolean[] {false, true, false, false, false, false};
  squares[3] = new boolean[] {false, false, false, false, true, false};
  squares[4] = new boolean[] {false, false, true, false, false, false};
  squares[5] = new boolean[] {false, true, false, true, false, false};
  squares[6] = new boolean[] {false, false, false, false, false, true};
  squares[7] = new boolean[] {false, false, false, true, false, false};
  squares[8] = new boolean[] {false, false, false, true, false, false};
  squares[9] = new boolean[] {false, false, false, false, false, true};
  squares[10] = new boolean[] {true, false, true, false, false, false};
  squares[11] = new boolean[] {false, false, true, false, false, false};
  squares[12] = new boolean[] {false, false, false, false, true, false};
  squares[13] = new boolean[] {false, true, false, false, false, false};
  squares[14] = new boolean[] {true, false, false, false, false, false};
  squares[15] = new boolean[] {false, false, false, false, false, false};
}

void draw() {
  background(255);loadPixels();
  
  for (int x = 0; x < width; x++){
    for (int y = 0; y < height; y++){
      pixels[x+y*width] = color(255*noise(x/scale,y/scale));
    }
  }
  updatePixels();
  for (int x = 0; x < 1+width/cw; x++) {
    for (int y = 0; y < 1+height/cw; y++) {

      drawSquare(x*cw, y*cw, noise((x*cw)/scale, (y*cw+cw)/scale), noise((x*cw+cw)/scale, (y*cw+cw)/scale), noise((x*cw+cw)/scale, (y*cw)/scale), noise((x*cw)/scale, (y*cw)/scale));
    }
  }
}

int mapsquare(boolean A, boolean B, boolean C, boolean D) {
  int val = (A?1:0)+(B?2:0)+(C?4:0)+(D?8:0);
  return val;
}
void drawSquare(float x, float y, float A, float B, float C, float D) {
  int ind = mapsquare(A>threshold, B>threshold, C>threshold, D>threshold);
  PVector down = new PVector(map(threshold, A, B, x, x+cw), y+cw);
  PVector right = new PVector(x+cw, map(threshold, C, B, y, y+cw));
  PVector up = new PVector(map(threshold, D, C, x, x+cw), y);
  PVector left = new PVector(x, map(threshold, D, A, y, y+cw));

  //fill(col(A));
  //circle(x, y+cw, 10);
  //fill(col(B));
  //circle(x+cw, y+cw, 10);
  //fill(col(C));
  //circle(x+cw, y, 10);
  //fill(col(D));
  //circle(x, y, 10);

  //ind = 15;
  if (squares[ind][0]) {
    //line(x, y+cw/2.0, x+cw/2.0, y+cw);
    line(left.x, left.y, down.x, down.y);
  } 
  if (squares[ind][1]) {
    //line(x+cw/2.0, y+cw, x+cw, y+cw/2.0);
    line(down.x, down.y, right.x, right.y);
  }
  if (squares[ind][2]) {
    //line(x+cw/2.0, y, x+cw, y+cw/2.0);    
    line(up.x, up.y, right.x, right.y);
  }
  if (squares[ind][3]) {
    //line(x, y+cw/2.0, x+cw/2.0, y); 
    line(up.x, up.y, left.x, left.y);
  }
  if (squares[ind][4]) {
    //line(x, y+cw/2.0, x+cw, y+cw/2.0);
    line(left.x, left.y, right.x, right.y);
  }
  if (squares[ind][5]) {
    //line(x+cw/2.0, y, x+cw/2.0, y+cw);
    line(up.x, up.y, down.x, down.y);
  }
}
color col(float x) {
  if (x > 0) {
    return color(255-x*255, 255-x*255, 255);
  } else {
    return color(255, 255+x*255, 255+x*255);
  }
}
