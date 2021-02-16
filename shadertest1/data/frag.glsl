#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_COLOR_SHADER
#define AMOUNT 10

uniform float disDensity;
uniform float[AMOUNT] pos1;
uniform float[AMOUNT] pos2;
uniform float[AMOUNT] shift;
uniform bool[AMOUNT] orient;
//uniform iSampler img;
uniform vec2 res;

void main() {
    //mainImage(gl_FragColor,gl_FragCoord.xy);
    //vec2 trpos = gl_FragCoord.xy / vec2(disDensity);
    vec2 trpos = vec2(gl_FragCoord.x / disDensity, gl_FragCoord.y / disDensity);
    bool test = false;
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
                    //test = !test;
                    trpos.y += shift[i];
                }else{
                    //test = !test;
                    trpos.x += shift[i];
                }
            }
        }else{
            if (key > pos1[i] || key < pos2[i]){
                if (!orient[i]){
                    //test = !test;
                    trpos.y += shift[i];
                }else{
                    //test = !test;
                    trpos.x += shift[i];
                }
            }
        }
        trpos = mod(trpos + res,res);
    }
    // if (test){
    //     gl_FragColor = vec4(vec3(0.),1.);
    // }else{
    //     gl_FragColor = vec4(vec3(1.),1.);
    // }
    // return;
    //trpos.x += shift[0];
//---------------------------
//trpos = vec2(gl_FragCoord.x / disDensity, gl_FragCoord.y / disDensity);
    vec2 normal = trpos / res.xy;
    //normal = trpos;
    gl_FragColor = vec4(1.,1.,1.,1.);
    // if (normal.x < 0.5) {
    //     gl_FragColor.x = normal.x * 2.;
    // }else{
    //     gl_FragColor.x = (1. - normal.x)*2.;
    // }
    // if (normal.y < 0.5) {
    //     gl_FragColor.y = normal.y * 2.;
    // }else{
    //     gl_FragColor.y = (1. - normal.y)*2.;
    // }
    //gl_FragColor.zw = vec2(0.,1.);

}
