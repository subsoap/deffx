varying mediump vec4 position;
varying mediump vec2 var_texcoord0;
varying mediump vec3 var_view_proj0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 trim;
uniform lowp vec4 ratio;

void main()
{
	lowp vec4 trim_by = vec4(1.0,1.0,1.0,1.0);

	if (var_texcoord0.x < trim.x * ratio.x || var_texcoord0.x > trim.y * ratio.x ) {
		trim_by = vec4(0.0,0.0,0.0,0.0);
	}

	gl_FragColor = texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy) * trim_by;
}
