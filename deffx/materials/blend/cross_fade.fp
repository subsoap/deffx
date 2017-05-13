varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp sampler2D BLEND;
uniform lowp vec4 progress;


void main()
{
	vec4 base = texture2D(DIFFUSE_TEXTURE, var_texcoord0);
	vec4 blend = texture2D(BLEND, var_texcoord0);
	//gl_FragColor = base * (1.0 - progress) + blend * progress;
	gl_FragColor = mix(base, blend, progress);
}