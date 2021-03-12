#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define AMOUNT 5

uniform float dense;
uniform vec2 res;
//
uniform float[AMOUNT] posx;
uniform float[AMOUNT] posy;
uniform float[AMOUNT] rad;
uniform float[AMOUNT] spin;

void main(){
    gl_FragColor = vec4(1.,0.,0.,1.);
}
