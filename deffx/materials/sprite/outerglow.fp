varying mediump vec2 var_texcoord0;
uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 color;

void main()
{
	vec4 sum = vec4(0);
	vec2 texcoord = var_texcoord0;
	if (texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy).a <= 0.8 )  {
	
	for(int xx = -1; xx <= 0; xx++) {
		for(int yy = 3; yy <= 4; yy++) {
			float dist = sqrt(float(xx*xx) + float(yy*yy));
			float factor = 0.0;
			if (dist == 0.0) {
				factor = 2.0;
			} else {
				factor = 2.0/abs(float(dist));
			}
			sum += texture2D(DIFFUSE_TEXTURE, texcoord + vec2(xx, yy) * 0.0005) * factor;
			sum.r = 255.0 * sum.a;
			sum.g = 255.0 * sum.a;
			sum.b = 255.0 * sum.a;
		}
	}

	}

	gl_FragColor = sum * 0.025 + texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy);
}
