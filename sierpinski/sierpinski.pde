float hs3 = sqrt(3)/2;
float x;
float y;
float l;
float zs = 1;
float maxzoom = 1.04;
int ll = 1;
//int 0 = 0;
boolean[] t = new boolean[10];
//boolean onscreen = true;

void setup() {
  noFill();

  strokeWeight(0.5);
  stroke(255,0,0);
  size(100, 100);
  //pixelDensity(displayDensity());
  x = width/6;
  y = height*5/6;
  l = width*2/3;
}

void draw() {
  background(0, 0, 0);
  stroke(255, 255, 255);

  if (mousePressed) {
    if (zs < maxzoom) {
      zs = zs + (maxzoom-zs)*0.1;
    }
  } else {
    if (zs > 1) {
      zs = zs + (1-zs)*0.2;
    }
  }
  x = (mouseX+(x-mouseX)*zs);
  y = (mouseY+(y-mouseY)*zs);
  l *= zs;

  t[0] = isOnScreen(x+l*0.375, y-l*hs3*0.75, l*0.25);
  t[1] = isOnScreen(x+l*0.25, y-l*hs3*0.5, l*0.25);
  t[2] = isOnScreen(x+l*0.5, y-l*hs3*0.5, l*0.25);
  t[3] = isOnScreen(x+l*0.125, y-l*hs3*0.25, l*0.25);
  t[4] = isOnScreen(x+l*0.625, y-l*hs3*0.25, l*0.25);
  t[5] = isOnScreen(x, y, l*0.25);
  t[6] = isOnScreen(x+l*0.25, y, l*0.25);
  t[7] = isOnScreen(x+l*0.5, y, l*0.25);
  t[8] = isOnScreen(x+l*0.75, y, l*0.25);
  t[9] = isOnScreen(x+l*0.375, y-l*hs3*0.25, l*0.25);
  boolean t1 = t[3]||t[5]||t[6];
  boolean t2 = t[4]||t[7]||t[8];
  boolean t3 = t[0]||t[1]||t[2];
  if (t1&&!t2&&!t3) {
    l = l/2;
  } else if (!t1&&t2&&!t3) {
    x = x+l/2;
    l = l/2;
  } else if (!t1&&!t2&&t3) {
    x = x+l/4;
    y = y-hs3*l/2;
    l = l/2;
  }
  /*if (isOnScreen(x, y, l/2)&&
   !isOnScreen(x+l/2, y, l/2)&&
   !isOnScreen(x+l/4, y-hs3*l/2, l/2)) {
   l = l/2;
   } else if (!isOnScreen(x, y, l/2)&&
   isOnScreen(x+l/2, y, l/2)&&
   !isOnScreen(x+l/4, y-hs3*l/2, l/2)) {
   x = x+l/2;
   l = l/2;
   } else if (!isOnScreen(x, y, l/2)&&
   !isOnScreen(x+l/2, y, l/2)&&
   isOnScreen(x+l/4, y-hs3*l/2, l/2)) {
   x = x+l/4;
   y = y-hs3*l/2;
   l = l/2;
   }*/
  if        (t[2] && t[4] && !t[3] && !t[1] && !t[6] && !t[7] && !t[0] && !t[8]&&!t[9]) {
    x = x+l*3/8;
    y = y-hs3*l/4;
    l = l/2;
  } else if (t[3] && t[1] && !t[2] && !t[4] && !t[6] && !t[7] && !t[0] && !t[5]&&!t[9]) {
    x = x+l/8;
    y = y-hs3*l/4;
    l = l/2;
  } else if (t[6] && t[7] && !t[2] && !t[4] && !t[3] && !t[1] && !t[8] && !t[5]&&!t[9]) {
    x = x+l/4;
    l = l/2;
  }
  se(x, y, l, 0);

}
void se(float x1, float y1, float l, int i) {
  if (i == 0) {
    triangle(x1, y1, x1+l, y1, x1+l/2, y1-hs3*l);
  } else if (i == 1) {
    line(x1, y1, x1+l, y1);
  } else if (i == 2) {
    line(x1+l, y1, x1+l/2, y1-hs3*l);
  } else if (i == 3) {
    line(x1, y1, x1+l/2, y1-hs3*l);
  }
  /*
  if (!onscreen) {
   if (x1>0&&x1<width&&y1>0&&y1<height) {
   onscreen = true;
   } else if (x1+l>0&&x1+l<width&&y1>0&&y1<height) {
   onscreen = true;
   } else if (x1+l/2>0&&x1+l/2<width&&y1-hs3*l>0&&y1-hs3*l<height) {
   onscreen = true;
   }
   }*/
  //rect(x1,y1-hs3*l,l,hs3*l);
  if (l>ll) {
    if (isOnScreen(x1, y1, l/2)) {
      se(x1, y1, l/2, 2);
    }
    if (isOnScreen(x1+l/2, y1, l/2)) {
      se(x1+l/2, y1, l/2, 3);
    }
    if (isOnScreen(x1+l/4, y1-hs3*l/2, l/2)) {
      se(x1+l/4, y1-hs3*l/2, l/2, 1);
    }
  }
}

boolean isOnScreen(float x, float y, float l) {
  //if ((x+l<0||x>width)) {
  //  return false;
  //}
  //if ((y-hs3*l>height||y<0)) {
  //  return false;
  //}
  ///*
  //if (!pt(0, height, x, y, l)) {
  // if (!pt(width, height, x, y, 1)) {
  // return false;
  // }
  // }*/
  //return true;
  if (x<width&&x>0&&y<height&&y>0) {
    return true;
  }
  if (x+l/2<width&&x+l/2>0&&y-hs3*l<height&&y-hs3*l>0) {
    return true;
  }
  if (x+l<width&&x+l>0&&y<height&&y>0) {
    return true;
  }
  if (intersect(x, y, x+l, y, 0, 0, 0, height)) {
    return true;
  }
  if (intersect(x, y, x+l, y, width, 0, width, height)) {
    return true;
  }
  //1
  if (intersect(x, y, x+l/2, y-hs3*l, 0, 0, width, 0)) {
    return true;
  }
  if (intersect(x, y, x+l/2, y-hs3*l, 0, 0, 0, height)) {
    return true;
  }
  if (intersect(x, y, x+l/2, y-hs3*l, width, 0, width, height)) {
    return true;
  }
  if (intersect(x, y, x+l/2, y-hs3*l, 0, height, width, height)) {
    return true;
  }
  //2
  if (intersect(x+l/2, y-hs3*l, x+l, y, 0, 0, width, 0)) {
    return true;
  }
  if (intersect(x+l/2, y-hs3*l, x+l, y,  0, 0, 0, height)) {
    return true;
  }
  if (intersect(x+l/2, y-hs3*l, x+l, y,  width, 0, width, height)) {
    return true;
  }
  if (intersect(x+l/2, y-hs3*l, x+l, y,  0, height, width, height)) {
    return true;
  }
  return false;
}
boolean intersect(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  if (!(isLeft(x1, y1, x2, y2, x3, y3)^isLeft(x1, y1, x2, y2, x4, y4))) {
    return false;
  }
  if (!(isLeft(x3, y3, x4, y4, x1, y1)^isLeft(x3, y3, x4, y4, x2, y2))) {
    return false;
  }
  return true;
}
boolean isLeft(float x1, float y1, float x2, float y2, float xt, float yt) {
  if ((y1-y2)*xt-(x1-x2)*yt>(-y2)*x1-(-x2)*y1) {
    return true;
  }
  return false;
}
/*
boolean pt(float x, float y, float xt, float yt, float l) {
 //(xt,yt)~(xt+l/2,y-l*hs3)~(xt+l,yt)
 if (y < yt) {
 if (y > -2*hs3*x+(yt+2*hs3*xt)) {
 if (y > 2*hs3*x+(yt-2*hs3*(xt+l))) {
 return true;
 }
 }
 }
 return false;
 }*/
void keyPressed() {
  if (key == 'r') {
    setup();
  }
}//hit R to reset
