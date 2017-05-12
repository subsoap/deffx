varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp sampler2D BLEND;


#define BlendColorDodgef(base, blend) 	((blend == 1.0) ? blend : min(base / (1.0 - blend), 1.0))
#define BlendColorBurnf(base, blend) 	((blend == 0.0) ? blend : max((1.0 - ((1.0 - base) / blend)), 0.0))
#define BlendVividLightf(base, blend) 	((blend < 0.5) ? BlendColorBurnf(base, (2.0 * blend)) : BlendColorDodgef(base, (2.0 * (blend - 0.5))))
#define Blend(base, blend, funcf) 		vec4(funcf(base.r, blend.r), funcf(base.g, blend.g), funcf(base.b, blend.b), 1.0)
#define BlendVividLight(base, blend) 	Blend(base, blend, BlendVividLightf)

void main()
{
	vec4 base = texture2D(DIFFUSE_TEXTURE, var_texcoord0);
	vec4 blend = texture2D(BLEND, var_texcoord0);
	if (blend.a < 0.3) {
		// incorrect solution to solving problem of trasparent areas not blending correctly
		gl_FragColor = texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy);
	} else {
		gl_FragColor = BlendVividLight(base, blend);
	}
	
}
