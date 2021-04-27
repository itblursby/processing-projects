public class PoissonDisk {
  //2d Poisson disk sampling
  private long phi = 1 << 16;
  private HashMap<Long, Integer> grid = new HashMap<Long, Integer>();
  private ArrayList<Integer> active = new ArrayList();
  private ArrayList<PVector> samples = new ArrayList();
  private float radius;
  private float gridlength;
  private int k = 20;
  //initial position and min distance
  public PoissonDisk(float x, float y, float r) {
    radius = r;
    gridlength = radius/sqrt(2);
    addNew(new PVector(x, y));
  }
  public PoissonDisk(float x, float y, float r, int k_) {
    radius = r;
    gridlength = radius/sqrt(2);
    addNew(new PVector(x, y));
    k = k_;
  }
  public PVector next() {
    while (true) {
      //selects a random PVector from the list of active samples
      int pindex = floor(active.size() * random(1));
      int index = active.get(pindex);
      PVector s = samples.get(index);
      for (int sam = 0; sam < k; sam++) {
        //generates k samples and sees if any of them 
        //are less than radius units away from any other sample
        float rand = TAU*random(1);
        float nx = s.x + (radius*random(1, 2))*cos(rand);
        float ny = s.y + (radius*random(1, 2))*sin(rand);
        long hashkey = hash(nx, ny);
        boolean good = true;
        if (!grid.containsKey(hashkey)) {
        checking:
          for (int i = -2; i < 3; i++) {
            for (int j = -2; j < 3; j++) {
              if (grid.containsKey(hashkey + i + (j * phi))) {
                PVector test = samples.get(grid.get(hashkey + i + (j * phi)));
                if (((test.x - nx)*(test.x - nx))+((test.y - ny)*(test.y - ny)) <= radius*radius) {
                  good = false;
                  break checking;
                }
              }
            }
          }
          if (good) {
            //line(s.x, s.y, nx, ny);
            return addNew(new PVector(nx, ny));
          }
        }
      }
      active.remove(pindex);
    }
  }

  private long hash(float x, float y) {
    return floor((x/gridlength)) + phi*(floor((y/gridlength)));
  }
  private PVector addNew(PVector s) {
    samples.add(s);
    active.add(samples.size()-1);
    println(hash(s.x, s.y));
    grid.put(hash(s.x, s.y), samples.size()-1);
    return s;
  }
}
