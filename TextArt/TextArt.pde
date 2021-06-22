PImage inputImage;
PFont font;
final String imageString = "gradient.png";

final int size = 11;

final char SPACE = ' ';

int density = 1;
//final 
float[] widths;
float[] luminance;
int[] sortbyluminance;

float xcoord = 0f;
float ycoord = 0f;
String outputText;
CompareKey comparer;
void setup() {
  size(700, 700);
  pixelDensity(displayDensity());
  density = displayDensity();

  background(255);
  fill(0);

  inputImage = loadImage(imageString);

  initTextState();
  widths = new float[95];
  fillArr(widths);
  println(java.util.Arrays.toString(widths));
  //print(textWidth('"'));
  //text("!!!!!!!!!!!!!!\n\"\"\"\"\"\"\"\"", 0, 0);
  luminance = new float[95];
  fillluminance(luminance, 120, 10, 5);
  println(java.util.Arrays.toString(luminance));

  //println((char)(max + SPACE));
  //println(luminance[max]);
  comparer = new CompareKey(luminance);
  sortbyluminance = new int[95];
  Integer[] helper = new Integer[95];
  for (int i = 0; i < 95; i++) {
    sortbyluminance[i] = i;
    helper[i] = new Integer(i);
  }
  //for (int i
  Arrays.sort(helper, comparer);
  for (int i = 0; i < 95; i++) {
    sortbyluminance[i] = helper[i].intValue();
  }

  println(Arrays.toString(sortbyluminance));
  for (int i = 0; i < 94; i++) {
    luminance[sortbyluminance[i]] = 255.*luminance[sortbyluminance[i]]/luminance[sortbyluminance[94]];
  }
  luminance[sortbyluminance[94]] = 255;
  println(java.util.Arrays.toString(luminance));
  for (int i = 0; i < 95; i++) {
    print((char)(sortbyluminance[i] + SPACE));
  }
  //for (i
  background(255);
  image(inputImage, 0, 0);
  inputImage.loadPixels();
  outputText = "";
}

void draw() {
  background(255);
  if (xcoord >= inputImage.width) {
    xcoord = 0;
    ycoord += size;
    outputText += "\n";
  }
  if (ycoord >= inputImage.height) {
    noLoop();
    //exit();
    text(outputText, 0, 0);
    print("\n"+outputText);
  } 
  int xr = (int)floor(xcoord);
  int yr = (int) floor(ycoord);

  int best = -1;
  float leasterror = Float.MAX_VALUE;
  for (int i = 0; i < 95; i++) {
    float w = widths[i];
    float h = size;
    int totalpix = 0;
    float col = 0;
    for (int x = 0; x < w; x++) { 
      for (int y = 0; x < h; x++) {
        if (x + xr < inputImage.width && y + yr < inputImage.height) {
          totalpix++;
          col += 255 - value(inputImage.pixels[x+xr+(y+yr)*inputImage.width]);
        }
      }
    }
    if (abs(luminance[i] - col/totalpix) < leasterror) {
      leasterror = abs(luminance[i] - col/totalpix);
      best = i;
    }
  }
  xcoord += widths[best];
  //best = (int) random(95);
  outputText += (char) (best + SPACE);
  text(outputText, 0, 0);
}
void fillArr(float[] arr) {
  //print("....");
  for (int i = 0; i < 95; i++) {
    arr[i] = textWidth((char)(SPACE + i));
    //print((char)(SPACE+i));
  }
  //print(java.util.Arrays.toString(arr));
}
void initTextState() {
  font = createFont("Arial", size);
  textFont(font);
  textSize(size);
  textLeading(size);
  textAlign(LEFT, TOP);
  fill(0);
}
void fillluminance(float[] arr, int space, int repeat, int rowl) {
  //PGraphics pg = createGraphics(300,size * 4);
  int input = 0;
  int sbx = space;
  int sby = size * 3;
  for (int y = 0; y < 1000 && input < 95; y++) {
    for (int x = 0; x < rowl && input < 95; x++) {
      String a = ""+(char)(SPACE+input);
      String b = "";
      for (int i = 0; i < repeat; i++) {
        b += a;
      }
      text(b + "\n" + b, x*sbx, y*sby-size);
      //text((char)(SPACE+input), x*space, y*size*2);

      //rect(x*size*2, y*size*2, widths[input], size);

      input++;
    }
  }
  loadPixels();
  for (int i = 0; i < 95; i++) {
    int tx = (i % rowl) * sbx*density;
    int ty = (i / rowl) * sby * density;
    float w = widths[i];


    int total = 0;
    for (int x = 0; x < density*ceil(w*repeat); x++) {
      for (int y = 0; y < density*size; y++) {
        total += 255-red(pixels[tx+x+(ty+y)*pixelWidth]);
        //pixels[tx+x+(ty+y)*pixelWidth] = color(255, 0, 0);
      }
    }
    luminance[i] = ((float)total) / (repeat*ceil(w*size)*density*density);
  }
  updatePixels();
}
float value(int col) {
  return red(col)*.3+green(col)*.6+blue(col)*.1;
}
