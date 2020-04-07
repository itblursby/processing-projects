float phi = (sqrt(5)+1)/2;
public class Sampler {
  int i = -1;
  Sampler() {
    this.i = 0;
  }
  float nextSample(){
    this.i++;
    return (phi * i)%1;
    
  }
}
