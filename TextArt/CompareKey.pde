import java.util.*;

public class CompareKey implements Comparator<Integer>{
  private float[] keylookup;
  public CompareKey(float[] a){
    keylookup = a;
  }
  //@Override
  public int compare(Integer a, Integer b){
    return (keylookup[a.intValue()] - keylookup[b.intValue()]) > 0?1:-1;
  }
}
