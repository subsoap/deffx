varying mediump vec2 var_texcoord0;
varying mediump vec3 var_position;
varying mediump vec3 var_normal;

void main() {

	gl_FragColor = vec4(normalize(var_normal) * 0.5 + 0.5, 1.0);
}