varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 options;
uniform lowp vec4 resolution;

void main()
{
    // Pre-multiply alpha since all runtime textures already are
    //lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    //gl_FragColor = texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy) * tint_pm;

	float d = 1.0 / options.x;
	float ar = resolution.x / resolution.y;
	float u = floor( var_texcoord0.x / d ) * d;
	d = ar / options.x;
	float v = floor( var_texcoord0.y / d ) * d;
	gl_FragColor = texture2D( DIFFUSE_TEXTURE, vec2( u, v ) );


}
