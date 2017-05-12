varying mediump vec2 var_texcoord0;
varying mediump vec3 var_position;
varying mediump vec3 var_normal;

uniform lowp vec4 options; // options.x = repeat distance

uniform lowp sampler2D DIFFUSE_TEXTURE;


void main() {
	float s = mod(floor(var_texcoord0.s * options.x), 2.0);
	float t = mod(floor(var_texcoord0.t * options.x), 2.0);

	if (s + t == 1.0)
	{
		gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
		//gl_FragColor = texture2D(DIFFUSE_TEXTURE, var_texcoord0);
	} else {
		gl_FragColor = vec4(1.0, 1.0, 0.0, 1.0);
	}
}



	