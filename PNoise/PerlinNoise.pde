public class PerlinNoise {
  private float seed1 = 12.9898;
  private float seed2 = 78.233;
  //private float seed3 = 49.281;
  private float seed4 = 43758.5453;
  private float random(float x, float y) {
    return (sin((x * seed1 + y * seed2))*seed4) % 1f;
  }
  //private float random(float x, float y) {
  //  return random(x,y,0f);
  //}
  //public PerlinNoise(float s1, float s2, float s3) {
  //  seed1 = s1;
  //  seed2 = s2;
  //  seed3 = s3;
  //}
  public PerlinNoise() {
    //seed1 = random(100,1000);
    //seed2 = random(100,1000);
    //seed3 = random(30000,99999);
  }
  public float noise(float x, float y) {
    float flx, fly;
    flx = floor(x);
    fly =floor(y);
    float fractx, fracty;
    fractx = x - floor(x);
    fracty = y - floor(y);
    float n1 = grad(fractx, fracty, random(flx, fly));
    float n2 = grad(fractx-1, fracty, random(flx+1, fly));
    float n3 = n1+ ip(fractx) * (n2-n1);
    n1 = grad(fractx, fracty-1, random(flx, fly+1));
    n2 = grad(fractx-1, fracty-1, random(flx+1, fly+1));
    float n4 = n1 + ip(fractx) * (n2-n1);
    return (n3 + ip(fracty)  * (n4-n3))/2+.5;
    //if (fractx < .5){


    //ffx
  }
  public float flowx(float x, float y) {
    float flx, fly;
    flx = floor(x);
    fly = floor(y);
    float fractx = x - flx;
    float fracty = y - fly;
    float n1 = cos(random(flx, fly)*TAU);
    float n2 = cos(random(flx+1, fly)*TAU);
    float n3 = n1 + fractx * (n2 - n1);
    n1 = cos(random(flx, fly+1)*TAU);
    n2 = cos(random(flx+1, fly+1)*TAU);
    float n4 = n1 + fractx * (n2 - n1);
    return n3 + fracty * (n4-n3);
  }
  public float flowy(float x, float y) {
    float flx, fly;
    flx = floor(x);
    fly = floor(y);
    float fractx = x - flx;
    float fracty = y - fly;
    float n1 = sin(random(flx, fly)*TAU);
    float n2 = sin(random(flx+1, fly)*TAU);
    float n3 = n1 + fractx * (n2 - n1);
    n1 = sin(random(flx, fly+1)*TAU);
    n2 = sin(random(flx+1, fly+1)*TAU);
    float n4 = n1 + fractx * (n2 - n1);
    return n3 + fracty * (n4-n3);
  }
  private float grad(float x, float y, float dir) {
    //x and y are deviation from point
    return x * cos(dir*TAU) + y * sin(dir*TAU);
  }
  //private float 
  private float ip(float v) {
    if (v > 1) {
      return 1;
    }
    if (v < 0) {
      return 0;
    }
    //if (v > .5){
    //  return 1;
    //}else{
    //  return 0;
    //}
    return 3 * v*v - 2*v*v*v;
  }
}
