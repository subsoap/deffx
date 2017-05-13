varying mediump vec2 var_texcoord0;
varying mediump vec3 var_position;
varying mediump vec3 var_normal;


uniform lowp sampler2D DIFFUSE_TEXTURE;


void main() {

	gl_FragColor = vec4(normalize(var_normal) * 0.5 + 0.5, 1.);
	//gl_FragColor = vec4(var_normal, 1.0);
}