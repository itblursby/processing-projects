Set a;
Set b;
Set c;
void setup(){
  a = new Set(1);
  b = new Set(2);
  c = new Set(3);
  b = a;
  //a = b;
  b = c;
  println(a.getIndex());
  println(b.getIndex());
  println(c.getIndex());
}
