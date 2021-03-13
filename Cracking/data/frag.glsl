#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define AMOUNT 40

uniform float dense;
uniform vec2 res;
uniform float[AMOUNT] posx;
uniform float[AMOUNT] posy;
uniform float[AMOUNT] rad;
uniform float[AMOUNT] sine;
uniform float[AMOUNT] cosine;
//uniform vec2 mouse;
vec2 endpos(vec2 uv);

void main(){
    vec2 uv = gl_FragCoord.xy/dense;
    uv.y = res.y-uv.y;
    vec2 new = endpos(uv);
    new /= res;
    new = abs((new * 2.)-vec2(1.));
    //new = abs(new);
    gl_FragColor = vec4(new.x,new.y,1.,1.);
}
vec2 endpos(vec2 uv){
    vec2 cpos = uv;
    //bool parity = false;
    for (int i = 0; i < AMOUNT; i++){
        float dx = cpos.x - posx[i];
        float dy = cpos.y - posy[i];
        if (abs(dx) > res.x/2.) dx = dx - sign(dx) * res.x;
        if (abs(dy) > res.y/2.) dy = dy - sign(dy) * res.y;
        bool within = (dx*dx+dy*dy)<(rad[i]*rad[i]);
        if (within){
            float nx = dx * cosine[i] - dy * sine[i];
            float ny = dx * sine[i] + dy * cosine[i];
            cpos = vec2(mod(posx[i]+nx,res.x),mod(posy[i]+ny,res.y));
            //parity = !parity;
        }

    }
    // if (parity) {
    //     gl_FragColor = vec4(0.,0.,0.,1.);
    //
    // }else{
    //     gl_FragColor = vec4(1.,0.,0.,1.);
    // }
    return cpos;
}
