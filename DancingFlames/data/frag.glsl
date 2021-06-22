#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

// #define PROCESSING_COLOR_SHADER
#define TAU 6.283185
#define CIRCLES 100
//
uniform vec2 res;
uniform float display;
uniform vec2 mouse;
uniform float itime;

uniform vec2 offset;
uniform float scale;
uniform float strength;
uniform int iterations;

uniform float lwidth;
uniform float dist;
uniform float circlesx[CIRCLES];
uniform float circlesy[CIRCLES];

float rand(vec2 w);
vec2 flow(vec2 w);
float noise(vec2 w);
float grad(vec2 l, vec2 d);
// float ss(float a);
float manhattanDistance(vec2 a, vec2 b);
void main(){
  vec2 uv = gl_FragCoord.xy / display;
  // uv = uv / iRes;
  float end = 0.;


  // vec2 flo = (uv/scale + offset);
  // uv = uv + flo * strength;
  // gl_FragColor =
  for (int i = 0; i < iterations; i++){
    vec2 flo = flow(uv /scale + offset);
    uv += strength * flo;
  }

  // gl_FragColor = vec4(uv/res,1.,1.);
  for (int i = 0; i < CIRCLES; i++){
    float m = min(smoothstep(dist+1.,dist,distance(uv,vec2(circlesx[i],circlesy[i]))),smoothstep(dist-lwidth,dist-lwidth+1.,distance(uv,vec2(circlesx[i],circlesy[i]))));

    end = max(end,m);
    //
  }
  // float end2 = end;
  // end *= distance(uv,res * 0.5) / (max(res.x,res.y)/2.);
  // end2 = (1.-end) *
  // vec4 col = vec4(noise(uv/scale + vec2(4382.5,91.4)),1.0,noise(uv/scale + vec2(28.5,11.4)),1.);
  vec2 flo = flow(uv /scale + offset);
  uv += 200. * flo;
  float d = distance(uv,res * 0.5);
  d = smoothstep(0,min(res.x,res.y)/2.,d);
  gl_FragColor = vec4(vec3(0.),1.);
  gl_FragColor = vec4(end * vec3(1.,d,0.),1.);
  // gl_FragColor = vec4(vec3(end),1.);
}

float rand(vec2 w){
  return fract(itime + sin(dot(w.xy,vec2(786.9898,78.233)))*43758.5453123);
  // return fract(t + itime);
}
vec2 flow(vec2 w){
  vec2 flr = floor(w);
  vec2 fct = fract(w);
  vec2 s1 = vec2(cos(rand(flr)*TAU),sin(rand(flr)*TAU));
  vec2 s2 = vec2(cos(rand(flr + vec2(1.,0.))*TAU),sin(rand(flr+ vec2(1.,0.))*TAU));
  vec2 s3 = s1 + smoothstep(0.,1.,fct.x) * (s2 - s1);
  s1 = vec2(cos(rand(flr + vec2(0.,1.))*TAU),sin(rand(flr+ vec2(0.,1.))*TAU));
  s2 = vec2(cos(rand(flr + vec2(1.,1.))*TAU),sin(rand(flr+ vec2(1.,1.))*TAU));
  vec2 s4 = s1 + smoothstep(0.,1.,fct.x) * (s2 - s1);
  return s3 + smoothstep(0.,1.,fct.y) * (s4 - s3);
  // vec4 vals = vec4(rand(flr),rand(flr+vec2(1.,0.)),rand(flr+vec2(0.,1.)),rand(flr)+vec2(1.,1.));
  // float s1 = (vals.x + fct.x * vals.y-vals.x);
  // float s2 = (vals.z + fct.x * vals.w-vals.z);
  // return s1 + fct.y * (s2 - s1);
}
float noise(vec2 w){
  vec2 flr = floor(w);
  vec2 fct = fract(w);
  float s1 = grad(flr,fct);
  float s2 = grad(flr+vec2(1.,0.),fct - vec2(1.,0.));
  float s3 = s1 + smoothstep(0.,1.,fct.x) * (s2 - s1);
  s1 = grad(flr + vec2(0.,1.), fct - vec2(0.,1.));
  s2 = grad(flr + vec2(1.,1.), fct - vec2(1.,1.));
  float s4 = s1 + smoothstep(0.,1.,fct.x) * (s2 - s1);
  return s3 + smoothstep(0.,1.,fct.y) * (s4 - s3);

}
float grad(vec2 l, vec2 d){
  float v = TAU * rand(l);
  return d.x * cos(v) + d.y * sin(v);
}
float manhattanDistance(vec2 a, vec2 b){
  return abs(a - b).x + abs(a-b).y;
}
// float ss
