IntList i = new IntList();
int sw = 1;
int sizex = 20;
int sizey = 10;
int a = 0;
int h;
int j = 0;
int st; 
void setup() {
  //noFill();
  //noStroke();
  st = color(255);
  background(0, 0, 0);
  size(600, 600);
  pixelDensity(displayDensity());
  stroke(st);
  strokeWeight(sw);
  i.append(sw);
  i.append(sw);
  i.append(width-sw);
  i.append(height-sw);
  randomcolor();
  rect(sw, sw, width-2*sw, height-2*sw);
  frameRate(60);
}
void draw() {
  for (int g = 0; g < 10; g++) {
    if (i.size() > 0) {
      
      a = i.size() - 4;
      a = (int) Math.floor(Math.random() * (i.size() / 4))*4;
      a = 0;
      if ((i.get(a+3)-i.get(a+1))/sizey>(i.get(a+2)-i.get(a))/sizex) {
        h = randint(i.get(a+1), i.get(a+3));
        //
        if (i.get(a+2)-i.get(a)>sizex||h-i.get(a+1)>sizey) {
          //i.splice(a+4, 0, i.get(a)+j, i.get(a+1)+j, i.get(a+2)-j, h-j);
          i.append(i.get(a)+j);
          i.append(i.get(a+1)+j);
          i.append(i.get(a+2)-j);
          i.append(h-j);
        }
        if (i.get(a+2)-i.get(a)>sizex||i.get(a+3)-h>sizey) {
          //i.splice(a+4, 0, i.get(a)+j, h, i.get(a+2)-j, i.get(a+3)-j);
          i.append(i.get(a)+j);
          i.append(h);
          i.append(i.get(a+2)-j);
          i.append(i.get(a+3)-j);
        }
        randomcolor();
        drect(i.get(a)+j, i.get(a+1)+j, i.get(a+2)-i.get(a)-2*j, h-i.get(a+1)-2*j);
        randomcolor();
        drect(i.get(a)+j, h, i.get(a+2)-i.get(a)-2*j, i.get(a+3)-h-j);

        //
        i.remove(a);
        i.remove(a);
        i.remove(a);
        i.remove(a);
        //console.log(i);
      } else {
        h = randint(i.get(a), i.get(a+2));
        if (h-i.get(a)>sizex||i.get(a+3)-i.get(a+1)>sizey) {
          //i.splice(a+4, 0, i.get(a)+j, i.get(a+1)+j, h, i.get(a+3)-j);
          i.append(i.get(a)+j);
          i.append(i.get(a+1)+j);
          i.append(h);
          i.append(i.get(a+3)-j);
        }
        if (i.get(a+2)-h>sizex||i.get(a+3)-i.get(a+1)>sizey) {
          //i.splice(a+4, 0, h+j, i.get(a+1)+j, i.get(a+2)-j, i.get(a+3)-j);
          i.append(h+j);
          i.append(i.get(a+1)+j);
          i.append(i.get(a+2)-j);
          i.append(i.get(a+3)-j);
        }
        randomcolor();
        drect(i.get(a)+j, i.get(a+1)+j, h-i.get(a)-j, i.get(a+3)-i.get(a+1)-2*j);
        randomcolor();
        drect(h+j, i.get(a+1)+j, i.get(a+2)-h-2*j, i.get(a+3)-i.get(a+1)-2*j);

        i.remove(a);
        i.remove(a);
        i.remove(a);
        i.remove(a);
      }
      if (i.size() == 0) {
        noLoop();
        //saveCanvas("mycanvas", "png");
      }
    }
  }
}
void randomcolor() {
  fill(random(255), random(255), random(255));
  /*
  if (random()
  */
  fill(0);
}

int randint(int a, int b) {
  return (int) Math.round(((Math.floor(Math.random() * (b-a))+a) + ((a+b)/2)+ ((a+b)/2))/3);
}
void drect(int x, int y, int l, int w) {
  if (l>=0&&w>=0) {
    if (l<sizex&&w<sizey) {
      //fill(st);
    }
    rect(x, y, l, w);
  }
}
