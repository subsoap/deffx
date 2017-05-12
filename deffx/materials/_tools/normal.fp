varying mediump vec2 var_texcoord0;
varying mediump vec3 var_position;
varying mediump vec3 var_normal;


uniform lowp sampler2D DIFFUSE_TEXTURE;


void main() {

	gl_FragColor = vec4(var_normal, 1.);
}