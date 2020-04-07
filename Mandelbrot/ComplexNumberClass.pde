class Complex {
  float real = 0;
  float imag = 0;
  Complex() {
  }
  Complex(float r, float i) {
    real = r;
    imag = i;
  }
  float getReal() {
    return this.real;
  }
  float getImag() {
    return this.imag;
  }
  Complex exreal(float p) {
    float d = sqrt(real*real+imag*imag);
    float t = 0;
    float temp = imag/d;
    if (real > 0) {
      t = asin(temp);
    }
    if (real <= 0) {
      t = PI-asin(temp);
    }
    float t2 = t*p;
    float d2 = pow(d, p);
    return new Complex(d2*cos(t2), d2*sin(t2));
  }
  Complex sq(){
    return new Complex(real*real-imag*imag,real*imag*2);
  }
  Complex add(Complex a) {
    real += a.getReal();
    imag += a.getImag();
    return this;
  }
  Complex sub(Complex a) {
    real -= a.getReal();
    imag -= a.getImag();
    return this;
  }
  float absqr(){
    return real*real+imag*imag;
  }
}
