varying mediump vec2 var_texcoord0;
uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 options;
// options.x = strength, options.y = magnitude, options.z = brightness, options.w = size
uniform lowp vec4 resolution;
uniform lowp vec4 time;


void main()

{

	vec2 pSize = (options.w * sin(var_texcoord0.y * options.y + time.x * options.x)) / vec2(resolution.x, resolution.y);
	float offsetX = sin(var_texcoord0.y * options.y + time.x * options.x) * pSize.x + cos(var_texcoord0.y * options.y + time.x * options.x * 1.3) * pSize.x;
	float corner = 10.0;


	if(var_texcoord0.x < 0.5) {
		if(var_texcoord0.y < 0.5) {
			options.z = min(var_texcoord0.x * var_texcoord0.y * corner, 1.0);
		} else {
			options.z = min(var_texcoord0.x * (1.0 - var_texcoord0.y) * corner, 1.0);
		}
	} else {
		if(var_texcoord0.y < 0.5) {
			options.z = min((1.0 - var_texcoord0.x) * var_texcoord0.y * corner, 1.0);
		} else {
			options.z = min((1.0 - var_texcoord0.x) * (1.0 - var_texcoord0.y) * corner, 1.0);
		}
	}

	float red = texture2D(DIFFUSE_TEXTURE, vec2(var_texcoord0.x + offsetX, var_texcoord0.y + pSize.y * 0.5)).r;
	float green = texture2D(DIFFUSE_TEXTURE, vec2(var_texcoord0.x + offsetX, var_texcoord0.y - pSize.y * 0.5)).g;
	float blue = texture2D(DIFFUSE_TEXTURE, vec2(var_texcoord0.x + offsetX, var_texcoord0.y)).b;

	if(mod(var_texcoord0.y * resolution.y, 2.0) > 0.5) {
		gl_FragColor = vec4(vec3(red, green, blue) * options.z, 1.0);
	} else {
		gl_FragColor = vec4(vec3(red * 0.75, green * 0.75, blue * 0.75) * options.z, 1.0);
	} 
}

