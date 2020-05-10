int cellsize = 1;
String rules = "C alive{}C dead{}";

enum Neighborhood {
  Normal, Orthagonal;
}
enum Compare{
  lessequal, less, equal, greater, greaterequal;
}
Neighborhood neighborType = Neighborhood.Normal;
BufferedReader r;
void setup() {
  try {
    r = createReader("conways.txt");
    for (int i = 0; i < 11; i++){
      
      println(r.readLine());
    }
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
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
