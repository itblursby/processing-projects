public interface valueGetter{
  public float getValue(int col);
}
class redGetter implements valueGetter{
  public float getValue(int col){
    return (col >> 16) & 0xFF;
  }
}
class blueGetter implements valueGetter{
  public float getValue(int col){
    return (col >> 8) & 0xFF;
  }
}
class greenGetter implements valueGetter{
  public float getValue(int col){
    return col & 0xFF;
  }
}
