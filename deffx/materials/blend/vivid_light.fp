varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp sampler2D BLEND;
uniform lowp vec4 tint;


vec4 VividLight( vec4 blend, vec4 base, float fill )
{
	vec4 canvas;

	blend.rgb = (mix( vec3(.5,.5,.5), blend.rgb, fill ) - 0.5) * 2.0;
	canvas.rgb = base.rgb + min(blend.rgb, 0.0);
	canvas.rgb /= max(1.0-abs(blend.rgb), 0.000001) * base.a;
	canvas = clamp( canvas, 0.0, 1.0 );
	canvas.rgb *= blend.a;
	canvas.a = blend.a * base.a;
	return canvas;
}

void main()
{
	vec4 base = texture2D( DIFFUSE_TEXTURE, var_texcoord0 );
	vec4 blend = texture2D( BLEND, var_texcoord0 ) * tint;
	vec4 canvas = VividLight( blend, base, gl_Color.a );

	canvas.rgb += (1.0 - blend.a) * base.rgb * base.a;
	canvas.a += (1.0 - blend.a) * base.a;
	blend.a *= gl_Color.a;
	canvas.rgb += (1.0 - base.a) * blend.rgb * blend.a;
	canvas.a += (1.0 - base.a) * blend.a;
	canvas.rgb /= canvas.a;
	
	gl_FragColor = canvas;
}