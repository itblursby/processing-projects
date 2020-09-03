public class PoissonDisk {
  //2d Poisson disk sampling
  private float phi = 1.0/(1 << 15);//(1+sqrt(5))/2;
  private HashMap<Float, Integer> grid = new HashMap<Float, Integer>();
  private ArrayList<Integer> active = new ArrayList(0);
  private ArrayList<PVector> samples = new ArrayList(0);
  private float radius;
  private float gridlength;
  private int k = 20;
  //initial position and min distance
  PoissonDisk(float x, float y, float r) {
    radius = r;
    gridlength = radius/sqrt(2);
    //print(gridlength);
    addNew(new PVector(x, y));
  }
  PoissonDisk(float x, float y, float r, int k_) {
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
        float hashkey = hash(nx, ny);
        boolean good = true;
        if (!grid.containsKey(hashkey)) {
          //delete this bit later:
          /*
          for (int i = 0; i < samples.size(); i++) {
           PVector test = samples.get(i);
           if (((test.x - nx)*(test.x - nx))+((test.y - ny)*(test.y - ny)) < radius*radius) {
           good = false;
           break;
           }
           }*/
          for (int i = -1; i < 2 && good; i++) {
            for (int j = -1; j < 2; j++) {
              if (grid.containsKey(hashkey + i + (j * phi))) {
                PVector test = samples.get(grid.get(hashkey + i + (j * phi)));
                if (((test.x - nx)*(test.x - nx))+((test.y - ny)*(test.y - ny)) < radius*radius) {
                  good = false;
                  break;
                }
              }
            }
            //if (!good) {
            //  break;
            //}
          }
          if (good) {
            //line(s.x, s.y, nx, ny);
            return addNew(new PVector(nx, ny));
          }
        }
      }
      //fill(255,0,0);
      //ellipse(s.x,s.y,10,10);
      //fill(255);
      active.remove(pindex);
    }
    //return null;
  }
  
  private float hash(float x, float y) {
    return floor(x/gridlength) + phi*floor(y/gridlength);
  }
  private PVector addNew(PVector s) {
    samples.add(s);
    active.add(samples.size()-1);
    println(hash(s.x, s.y));
    grid.put(hash(s.x, s.y), samples.size()-1);
    return s;
  }
}
