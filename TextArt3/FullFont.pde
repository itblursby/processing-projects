public class FullFont {

  private PFont font;
  private float size;
  private float spacing;
  private float[] widths = new float[95];
  private float[] values = new float[95];
  public FullFont(PFont font, float size, float spacing) {
    this.font = font;
    this.size = size;
    this.spacing = spacing;
    textFont(font);
  }
}
