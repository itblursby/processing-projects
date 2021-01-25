#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 iResolution;
uniform vec2 iMouse;
uniform float iTime;
void main(){
    gl_FragColor = vec4(1.,1.,1.,0.);
}
