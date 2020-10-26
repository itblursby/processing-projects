import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Metaballs extends PApplet {

final int resolution = 10;
final int amount = 10;
final int threshold = 1;
final int minsize = 25;
final int maxsize = 40;
final PVector offA = new PVector(0, resolution);
final PVector offB = new PVector(resolution, resolution);
final PVector offC = new PVector(resolution, 0);
final PVector offD = new PVector(0, 0);
Metaball[] meta = new Metaball[amount];
boolean[][] squares = new boolean[16][6];
public void setup() {
  strokeWeight(5);
  
  for (int i = 0; i < amount; i++) {
    meta[i] = new Metaball();
  }
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
public void draw() {
  background(255);
  //for (int x = 0; x < 1+width/cw; x++) {
  //  for (int y = 0; y < 1+height/cw; y++) {
  //  }
  //}
  for (int i = 0; i < amount; i++) {
    meta[i].move();
    //meta[i].display();
  }
  for (int x = 0; x < 1+width/resolution; x++) {
    for (int y = 0; y < 1+height/resolution; y++) {
      PVector cur = new PVector(x*resolution, y*resolution);
      float A = 0;
      float B = 0;
      float C = 0;
      float D = 0;
      for (int i = 0; i < amount; i++) {
        A += meta[i].inf(PVector.add(cur, offA));
        B += meta[i].inf(PVector.add(cur, offB));
        C += meta[i].inf(PVector.add(cur, offC));
        D += meta[i].inf(PVector.add(cur, offD));
      }
      
      drawSquare(cur.x, cur.y, A, B, C, D);
    }
  }
}
public int mapsquare(boolean A, boolean B, boolean C, boolean D) {
  int val = (A?1:0)+(B?2:0)+(C?4:0)+(D?8:0);
  return val;
}
public void drawSquare(float x, float y, float A, float B, float C, float D) {
  int ind = mapsquare(A>threshold, B>threshold, C>threshold, D>threshold);
  PVector down = new PVector(map(threshold, A, B, x, x+resolution), y+resolution);
  PVector right = new PVector(x+resolution, map(threshold, C, B, y, y+resolution));
  PVector up = new PVector(map(threshold, D, C, x, x+resolution), y);
  PVector left = new PVector(x, map(threshold, D, A, y, y+resolution));

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
  public void move() {
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
  public float inf(PVector a){
    return radius2/((a.x-pos.x)*(a.x-pos.x)+(a.y-pos.y)*(a.y-pos.y));
  }
  public void display(){
    ellipse(pos.x,pos.y,radius+radius,radius+radius);
  }
}
  public void settings() {  size(600, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#FFFFFF", "--stop-color=#FF0000", "Metaballs" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
