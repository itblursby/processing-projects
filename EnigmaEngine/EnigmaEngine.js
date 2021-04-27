//general state of entire script
const RUNNING = 0;
const ROTORSET = 1;
const PLUGSET = 2;
// const PHI = (sqrt(5)-1)/2;
var state = RUNNING;

//choosing plugboard settings
var last = -1;


var fontOrelega;

const kbspace = [0.0, 0.2, 0.8];
const kbmargin = 5;
const kbkeys = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"];
const letterA = "A".charCodeAt(0);
const kblettersize = 40;
const kbkeysize = 60;
const kblettershade =  200;

var letterPos = [];

const cipherkbpos = [20, 200];
const plugboardpos = [20, 400];

var plugboard = [];


function preload() {
  fontOrelega = loadFont("OrelegaOne-Regular.ttf");
}
function setup() {
  createCanvas(windowWidth, windowHeight);
  background(100);

  //noFill();

  textAlign(CENTER, CENTER);
  textFont(fontOrelega);
  ellipseMode(CORNER);

  //setup letter arrays/values for lookup
  for (let i = 0; i < 26; i++) {
    letterPos.push(null);
  }
  for (let i = 0; i < kbkeys.length; i++) {
    for (let j = 0; j < kbkeys[i].length; j++) {
      let t = kbkeys[i].charCodeAt(j) - letterA;
      letterPos[t] = [j, i];
    }
  }
  for (let i = 0; i < 26; i++) {
    plugboard.push(-1);
  }

  //print(letterPos);
  stroke(0);
}

function draw() {
  background(255);
  drawKeyboard(cipherkbpos[0], cipherkbpos[1], kbkeysize, kblettersize, false);
  drawKeyboard(plugboardpos[0], plugboardpos[1], kbkeysize, kblettersize, true);
  for (let i = 0; i < 26; i++) {
    if (plugboard[i] != -1 && i < plugboard[i]) {

      let pos1 = getPos(plugboardpos[0], plugboardpos[1], i);
      let pos2 = getPos(plugboardpos[0], plugboardpos[1], plugboard[i]);
      lineB(pos1[0] + kbkeysize/2, pos1[1]+ kbkeysize/2, pos2[0]+ kbkeysize/2, pos2[1]+ kbkeysize/2);
    }
  }
  if (state == PLUGSET) {
    // ellipse(mouseX,mouseY,10,10);
    let x = plugboardpos[0] + kbkeysize * letterPos[last][0] + kbkeysize*kbspace[letterPos[last][1]];
    let y = plugboardpos[1] + kbkeysize * letterPos[last][1];
    print(x + ", " + y);
    noFill();
    stroke(0, 0, 255);
    strokeWeight(1);
    ellipse(x, y, kbkeysize, kbkeysize);
    stroke(0);
  }

  // mousePressed();
}
//letter is 0-25 - indicating letter.
function addLetter(letter) {
}
function drawKeyboard(x, y, size, tsize, circle) {
  strokeWeight(1);
  if (!circle) {
    textSize(tsize);
    for (let i = 0; i < 10; i++) {
      noFill();
      stroke(0);
      rect(x+i*size+kbmargin/2, y+kbmargin/2, size-kbmargin, size-kbmargin);
      fill(200);
      noStroke();

      text(kbkeys[0].charAt(i), x+i*size+size/2, y+size/2);
    }
    for (let i = 0; i < 9; i++) {
      noFill();
      stroke(0);
      rect(x+i*size+kbmargin/2 + kbspace[1] * size, size + y+kbmargin/2, size-kbmargin, size-kbmargin);
      fill(200);
      noStroke();

      text(kbkeys[1].charAt(i), x+i*size+size/2 + kbspace[1] * size, y+size/2+size);
    }
    for (let i = 0; i < 7; i++) {
      noFill();
      stroke(0);
      rect(x+i*size+kbmargin/2 + kbspace[2] * size, 2*size + y+kbmargin/2, size-kbmargin, size-kbmargin);
      fill(200);
      noStroke();

      text(kbkeys[2].charAt(i), x+i*size+size/2 + kbspace[2] * size, y+size/2+2*size);
    }
  } else {
    textSize(tsize);
    for (let i = 0; i < 10; i++) {
      noFill();
      stroke(0);
      ellipse(x+i*size+kbmargin/2, y+kbmargin/2, size-kbmargin, size-kbmargin);
      fill(kblettershade);
      noStroke();

      text(kbkeys[0].charAt(i), x+i*size+size/2, y+size/2);
    }
    for (let i = 0; i < 9; i++) {
      noFill();
      stroke(0);
      ellipse(x+i*size+kbmargin/2 + kbspace[1] * size, size + y+kbmargin/2, size-kbmargin, size-kbmargin);
      fill(kblettershade);
      noStroke();

      text(kbkeys[1].charAt(i), x+i*size+size/2 + kbspace[1] * size, y+size/2+size);
    }
    for (let i = 0; i < 7; i++) {
      noFill();
      stroke(0);
      ellipse(x+i*size+kbmargin/2 + kbspace[2] * size, 2*size + y+kbmargin/2, size-kbmargin, size-kbmargin);
      fill(kblettershade);
      noStroke();
      text(kbkeys[2].charAt(i), x+i*size+size/2 + kbspace[2] * size, y+size/2+2*size);
    }
  }
}
function mousePressed() {

  if ((mouseX > plugboardpos[0] && mouseX < plugboardpos[0] + 10 * kbkeysize) && (mouseY > plugboardpos[1] && mouseY < plugboardpos[1] + 3 * kbkeysize)) {

    let row = ~~((mouseY - plugboardpos[1])/kbkeysize);
    let col = ((mouseX - plugboardpos[0] - kbspace[row]*kbkeysize)/kbkeysize);
    if (col >= 0) {
      col = ~~col;
      if (col >= 0 && col < kbkeys[row].length) {
        let tkey = kbkeys[row].charCodeAt(col) - letterA;

        if (state == RUNNING) {
          if (plugboard[tkey] != -1) {
            plugboard[plugboard[tkey]] = -1;
            plugboard[tkey] = -1;
          } else {
            state = PLUGSET;
            last = tkey;
          }
        } else if (state == PLUGSET) {
          if (tkey == last) {
            state = RUNNING;
            last = -1;
          } else {
            if (plugboard[tkey] != -1) {

              plugboard[plugboard[tkey]] = -1;
              plugboard[tkey] = -1;
              // plugboard
            }
            plugboard[tkey] = last;
            plugboard[last] = tkey;
            state = RUNNING;
            print(plugboard);
          }
        }
      } else {
        if (state == PLUGSET) {
          state = RUNNING;
          last = -1;
        }
      }

      // print(tkey);
    }

    // if (col == 0){
    //   circle(mouseX,mouseY,10);
    // }

    // for (let i = 0; i < 3; i++){
    //   for (let j = 0; j < kbkeys[i].length(); j++){
    //     if (
    //   }
    // }
  } else if (state == PLUGSET) {
    state = RUNNING;
    last = -1;
  }
  // print("hi");
}
// function rmPlug(i,j){
//   plugboard[i] = -1;
//   plugboard[j] = -1;
// }
function lineB(x1, y1, x2, y2, r) {

  noFill();
  if (r) {
    stroke(255, 0, 0);
  } else {
    stroke(0);
  }
  bezier(x1, y1, x1, y1+70, x2, y2+70, x2, y2);
}
function getPos(x, y, l) {
  let ny = y + kbkeysize * letterPos[l][1];
  let nx = x + (letterPos[l][0] + kbspace[letterPos[l][1]]) * kbkeysize;
  return [nx, ny];
}
