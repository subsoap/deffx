varying mediump vec2 var_texcoord0;
varying mediump vec3 var_position;
varying mediump vec3 var_normal;

uniform lowp vec4 color_inner;
uniform lowp vec4 color_outer;


void main() {

    float ratio = -1 * dot(normalize(var_position),normalize(var_normal));
    clamp(ratio,0.0,1.0);
    gl_FragColor = mix(color_outer,color_inner,ratio);
}