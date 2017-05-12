varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 tint;
uniform lowp vec4 options; // options.x = lighten multiplier amount

void main()
{

    vec4 color = texture2D(DIFFUSE_TEXTURE, var_texcoord0);
	lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);    
    gl_FragColor = vec4(pow(color.r, options.x), pow(color.g, options.x), pow(color.b, options.x), color.a) * tint_pm;
}

