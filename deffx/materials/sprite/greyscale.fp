varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 tint;

void main()
{

    vec4 color = texture2D(DIFFUSE_TEXTURE, var_texcoord0);
	float luminance = 0.2126*color.r + color.g*0.7152 + color.b*0.0722;
	lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);    
    gl_FragColor = vec4(luminance,luminance,luminance, color.a) * tint_pm;
}