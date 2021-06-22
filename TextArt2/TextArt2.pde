PImage inputImage;
String imagePath = "gradient copy.png";
PFont font;
PImage image;
int fSize = 11;

TextGenerator generator;

final char SP = ' ';
void setup() {
  size(600, 600);
  background(255);
  image = loadImage(imagePath);
  image(image, 0, 0);
  //print("gotsomewhere");

  generator = new TextGenerator();
  font = createFont("Arial", 12);
  println(generator.setFont(font, 12, 12));
  textSize(12);
  textLeading(12);
  textAlign(LEFT, TOP);
  generator.setImage(image);

  //fill(0);
  //text(generator.solve(), 0, 0);
}
void draw() {
}
