#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define AMOUNT 30

uniform float dense;
uniform vec2 res;
uniform float[AMOUNT] posx;
uniform float[AMOUNT] posy;
uniform float[AMOUNT] rad;
uniform float[AMOUNT] sine;
uniform float[AMOUNT] cosine;
//uniform vec2 mouse;
vec2 endpos(vec2 uv);
vec4 getcol(vec2 uv);
float lessthan(float x, float y){
    return max(sign(y - x), 0.0);
}
void main(){
    vec2 uv = gl_FragCoord.xy/dense;
    uv.y = res.y-uv.y;
    vec2 new = endpos(uv);
    new /= res;
    new = abs((new * 2.)-vec2(1.));
    //new = abs(new);
    gl_FragColor = vec4(new.x,new.y,1.,1.);
    // vec4 color = vec4(0.);
    // color += getcol(endpos(uv-vec2(.25,.25)));
    // color += getcol(endpos(uv-vec2(-.25,.25)));
    // color += getcol(endpos(uv-vec2(-.25,-.25)));
    // color += getcol(endpos(uv-vec2(.25,.25)));
    //
    // gl_FragColor = color/4.;
}
vec4 getcol(vec2 uv){
    vec2 new = uv;
    new /= res;
    new = abs((new * 2.)-vec2(1.));
    return vec4(new.x,new.y,1.,1.);
}
vec2 endpos(vec2 uv){
    vec2 cpos = uv;
    //bool parity = false;
    for (int i = 0; i < AMOUNT; i++){
        float dx = cpos.x - posx[i];
        float dy = cpos.y - posy[i];
        dx = dx-lessthan(-abs(dx),-res.x/2.)*(sign(dx)*res.x);
        dy = dy-lessthan(-abs(dy),-res.y/2.)*(sign(dy)*res.y);
        // if (abs(dx) > res.x/2.) {dx = dx - sign(dx) * res.x;}
        // if (abs(dy) > res.y/2.) {dy = dy - sign(dy) * res.y;}
        float within = lessthan((dx*dx+dy*dy),(rad[i]*rad[i]));
        //bool within = (dx*dx+dy*dy)<(rad[i]*rad[i]);
        float nx;
        float ny;
        nx = dx * (1. + within * (cosine[i]-1.)) - within*dy * (1. + within * (sine[i]-1.));
        ny = dx * within*(1. + within * (sine[i]-1.)) + dy * (1. + within * (cosine[i]-1.));
        // if (within == 1.){
        //     nx = dx * cosine[i] - dy * sine[i];
        //     ny = dx * sine[i] + dy * cosine[i];
        //     cpos = vec2(mod(posx[i]+nx,res.x),mod(posy[i]+ny,res.y));
        //     //parity = !parity;
        // }
        cpos = vec2(mod(posx[i]+nx,res.x),mod(posy[i]+ny,res.y));

    }
    // if (parity) {
    //     gl_FragColor = vec4(0.,0.,0.,1.);
    //
    // }else{
    //     gl_FragColor = vec4(1.,0.,0.,1.);
    // }
    return cpos;
}
