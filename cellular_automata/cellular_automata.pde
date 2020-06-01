int cellsize = 10;
String rules = "";
ArrayList<String> segmentslist = new ArrayList<String>(0);

enum Neighborhood {
  Normal, Orthagonal;
}

Neighborhood nbType = Neighborhood.Normal;
enum Compare {
  lessequal, less, equal, greater, greaterequal;
}
BufferedReader r;
void setup() {
  size(300, 300);
  try {
    r = createReader("conways.txt");
    while (true) {
      String temp = r.readLine();
      if (temp == null) {
        break;
      } else {
        rules += temp;
      }
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
  print(rules);
}
void draw() {
}
boolean isWhitespace(char a) {
  if (a == ('\n')) {
    return true;
  }
  if (a == ('\t')) {
    return true;
  }
  if (a == (' ')) {
    return true;
  }
  return false;
}
