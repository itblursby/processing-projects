
class TextGenerator {
  //public static valueGetter defaultValueGetter;
  //static {
  //  defaultValueGetter = new valueGetter() {
  //    public float getValue(int col) {
  //      return ((col>>16) & 1) * 0.2 + ((col>>8) & 1) * 0.7 + ((col) & 1) * 0.1;
  //    }
  //  };
  //}

  //public static final int testint = 4;
  private PFont font;
  private float size;
  private float spacing;
  private PImage image;
  private String output;
  private PGraphics pg; 

  private int maxWidth;
  private floatComparer fC = new floatComparer();

  float[] widths = new float[95];
  float[] value = new float[95];
  int[] sortedValue = new int[95];
  int[] sortedWidths = new int[95];
  Integer[] intproxy = new Integer[95];
  private float x = 0;
  private float y = 0;

  public TextGenerator() {
    pg = createGraphics(300, 50);
    pg.smooth();
    //pg.beginDraw();
  }

  public void setImage(PImage image) {
    this.image = image;
    image.loadPixels();
    x = 0;
    y = 0;
    output = "";
  }
  public String setFont(PFont font, int size, int spacing) {
    //textFont(font);
    //pg = createGraphics(300,size * 4);
    this.font = font;
    this.size = size;
    this.spacing = spacing;
    if (size *5 > pg.height) {
      pg = createGraphics(300, size*5);
      //print("creat
      pg.smooth();
      //pg.beginDraw();
    }

    //print(this.font ==);
    //pg.beginDra
    //pg.textFont(this.font);

    //pg.textSize(this.size);
    //pg.textLeading(this.spacing);
    //image(pg, 0, 0);
    for (int i = 0; i < 95; i++) {
      //basic properties and beginDraw
      pg.beginDraw();
      pg.textFont(this.font);
      pg.textSize(this.size);
      pg.textLeading(this.spacing);
      pg.textAlign(LEFT, TOP);
      pg.background(0);
      pg.fill(255);
      //pg.pixelDensity(1);
      widths[i] = pg.textWidth((char)(i+' '));

      String a = "";
      for (int j = 0; j < 10; j++) {
        a = a + (char)(i+SP);
      }

      pg.text(a, 10, size);
      //text(a, 10, size);
      pg.text(a, 10, size*2);
      //text(a, 10, size*2);

      pg.text(a, 10, size*3);
      //text(a, 10, size*3);

      pg.endDraw();
      //image(pg,0,0);
      pg.loadPixels();

      int totalpix = (int)(widths[i]*10)*size; 
      float totallum = 0;
      for (int x = 0; x < (int)(widths[i]*10); x++) {
        for (int y = 0; y < size; y++) {
          //point(x+10,y+size);
          int cpix = pg.pixels[x+10+(y+size)*pg.pixelWidth];
          totallum += red(cpix);
        }
      }
      //println (totalpix);
      value[i] = totallum/totalpix;
      sortedValue[i] = i;
      sortedWidths[i] = i;
    }

    //SORTING BY VALUE
    for (int i = 0; i < 95; i++) {
      intproxy[i] = i;
    }
    fC.setKey(value);
    java.util.Arrays.sort(intproxy, fC);
    for (int i = 0; i < 95; i++) {
      sortedValue[i] = intproxy[i].intValue();
    }
    //SORTING BY WIDTH
    for (int i = 0; i < 95; i++) {
      intproxy[i] = i;
    }
    fC.setKey(widths);
    java.util.Arrays.sort(intproxy, fC);

    for (int i = 0; i < 95; i++) {
      sortedWidths[i] = intproxy[i].intValue();
    }
    maxWidth = ceil(widths[sortedWidths[94]]);
    String thingy = "";
    for (int i = 0; i < 95; i++) {
      thingy += (char)(' '+sortedValue[i]);
    }
    println(java.util.Arrays.toString(value));
    println(java.util.Arrays.toString(widths));
    //for (int i = 0; i < 95; i++){
    //  float factor = 
    //}
    //println(java.util.Arrays.toString(sortedValue));


    return thingy;
  }
  public String getString() {
    return output;
  }
  public String solve() {
    x = 0;
    y = 0;
    output = "";
    while (y < this.image.height) {
      char best = '¡';
      float maxDif = Float.MAX_VALUE;

      for (int i = 0; i < 95; i++) {
        int totalpix = 0;
        float totallum = 0;
        //
        for (int x1 = round(x); x1 < x + widths[i] && x1 < this.image.width; x1++) {
          for (int y1 = round(y); y < y1 + size && y1 < this.image.height; y1++) {
            totalpix++;
            totallum += luminance(image.pixels, x1, y1);
          }
        }
        totallum /= totalpix;
        print(totallum + " ");
        if (Math.abs(totallum - value[i]) < maxDif) {
          maxDif = Math.abs(totallum - value[i]);

          best = (char)(i+' ');
        }
      }
      //best = (char)((int)(random(1) * 95) + ' ');
      x += widths[(int)(best-' ')];      
      //print(x);
      //print(x + " ");
      output += best;
      if (x > this.image.width) {
        output += '\n';
        x = 0;
        y += size;
      }
      //print(y);
    }
    return output;
  }
  private float luminance(int[] pixels, int x, int y) {
    int col = pixels[x+y*this.image.width];
    //return .2*red(col)+.7*green(col)+.1*blue(col);
    return red(col);
  }
  //public float luminance(int a) {
  //  return red(a)*.2 + green(a)*.7+blue(a)*.1;
  //}
}
