varying mediump vec2 var_texcoord0;
varying mediump vec3 var_position;
varying mediump vec3 var_normal;

uniform lowp vec4 color_highlight;
uniform lowp vec4 color_mid;
uniform lowp vec4 color_shadow;
uniform lowp vec4 highlight_size;
uniform lowp vec4 shadow_size;
uniform lowp vec4 outline_width;

varying mediump vec3 light_position_transformed;

void main() {

    //float ratio = -1 * dot(normalize(var_position),normalize(var_normal));
    //clamp(ratio,0.0,1.0);
    //gl_FragColor = mix(color_outer,color_inner,ratio);

	vec3 light_position_normalized = normalize(light_position_transformed);

    float lambert = dot(light_position_normalized,var_normal);
    vec4 color = color_mid;
    if (lambert > highlight_size.x) color = color_highlight;
    if (lambert < shadow_size.x) color = color_shadow;
    if (dot(var_normal,var_position + 3.8) < outline_width.x) color = color_mid; //vec4(0.0,0.0,0.0,1.0);

    gl_FragColor = color;


}