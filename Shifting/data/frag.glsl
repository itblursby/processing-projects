#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

//#define PROCESSING_COLOR_SHADER
#define AMOUNT 20
#define COLOR_MODE 2
uniform float disDensity;
uniform float[AMOUNT] pos1;
uniform float[AMOUNT] pos2;
uniform float[AMOUNT] shift;
uniform bool[AMOUNT] orient;
uniform float[AMOUNT] col;
uniform sampler2D img;
uniform vec2 res;

vec2 getPos(out int rects, out float color, in vec2 trpos);
void main() {
    //mainImage(gl_FragColor,gl_FragCoord.xy);
    //vec2 trpos = gl_FragCoord.xy / vec2(disDensity);
    vec2 trpos = vec2(gl_FragCoord.x / disDensity, gl_FragCoord.y / disDensity);
    int times;
    float end;
    //trpos = (res/2.+(trpos-res/2.)/(1.+length(trpos - (res/2.))/200.));
    // if (mod(trpos.y,2.) <= 1.){
    //     trpos.x = trpos.x + sin(trpos.y/30.)*20.;
    // }else{
    //     trpos.x = trpos.x + sin(trpos.y/30.)*-20.;
    // }
    //trpos.y = trpos.y + sin(trpos.x/30.)*20.;
    trpos = getPos(times, end, trpos);

//---------------------------
    vec2 normal = trpos / res.xy;
    float xval;
    float yval;
    if (normal.x < 0.5) {
        xval = normal.x * 2.;
        //gl_FragColor.x = xval;
    }else{
        xval = (1. - normal.x)*2.;
        //gl_FragColor.x = xval;
    }
    if (normal.y < 0.5) {
        yval = normal.y * 2.;
        //gl_FragColor.y = yval;
    }else{
        yval = (1. - normal.y)*2.;
        //gl_FragColor.y = yval;
    }
    if (COLOR_MODE == 0) {
        gl_FragColor = vec4(0.,0.,1.,1.);
        if (times % 2 == 1) {
            gl_FragColor = vec4(1.,1.,1.,1.);
        }else{
            gl_FragColor = vec4(0.,0.,0.,1.);
        }
        return;
    } else if (COLOR_MODE == 1){
        xval = (xval/3.)+0.666;
        yval = (yval/3.)+0.666;
        xval *= xval;
        yval *= yval;
        //*************
        xval = min(1.,(xval));
        yval = min(1.,(yval));
        gl_FragColor.xyz = vec3(xval,vec2(yval));
        //gl_FragColor.yz = vec2(yval);
        gl_FragColor.xyz = vec3(1.)-gl_FragColor.xyz;
        gl_FragColor.w = 1.;
        return;
    }else if (COLOR_MODE == 2){
    //**************
        gl_FragColor = vec4(vec2(xval,yval),1.,1.);
        //gl_FragColor.zx = 0.2;
    //gl_FragColor = vec4(texture(img,vec2(normal.x,1.-normal.y)));
    }else if (COLOR_MODE == 3){
        gl_FragColor = vec4(vec3(mod(end,1.)),1.);
    }

}
vec2 getPos(out int rects, out float color, in vec2 trpos){
    float endcol = 0.;
    int times = 0;
    for (int i = 0; i < AMOUNT; i++){
        float key;
        if (!orient[i]){
            key = trpos.x;
        }else{
            key = trpos.y;
        }
        if (pos1[i] < pos2[i]){
            if (key > pos1[i] && key < pos2[i]){
                if (!orient[i]){
                    //test += 1;
                    trpos.y += shift[i];
                }else{
                    trpos.x += shift[i];
                }
                times += 1;
                endcol += col[i];
            }
        }else{
            if (key > pos1[i] || key < pos2[i]){
                if (!orient[i]){
                    trpos.y += shift[i];
                }else{
                    trpos.x += shift[i];
                }
                times += 1;
                endcol += col[i];
            }

        }
        trpos = mod(trpos + res,res);
    }
    rects = times;
    color = endcol;
    return trpos;
}
