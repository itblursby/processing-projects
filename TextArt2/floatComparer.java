import java.util.Comparator;

public class floatComparer implements Comparator<Integer> {
  private float[] keys;
  public void setKey(float[] k) {
    this.keys = k;
  }
  public int compare(Integer a, Integer b) {
    if (keys[a.intValue()] > keys[b.intValue()]) {
      return 1;
    }
    if (keys[a.intValue()] < keys[b.intValue()]) {
      return -1;
    }
    return 0;
  }
}
