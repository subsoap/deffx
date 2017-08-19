varying mediump vec2 var_texcoord0;
uniform lowp sampler2D POST_TEXTURE;

uniform lowp vec4 options;

vec4 apply_fxaa() {
    // The parameters are hardcoded for now, but could be
    // made into uniforms to control from the program.
	vec2 tex_offset = vec2(1.0, 1.0);
    float FXAA_SPAN_MAX = 8.0;
    float FXAA_REDUCE_MUL = 1.0/8.0;
    float FXAA_REDUCE_MIN = (1.0/128.0);
    
    vec3 rgbNW = texture2D(POST_TEXTURE, var_texcoord0.xy + (vec2(-1.0, -1.0) * tex_offset)).xyz;
    vec3 rgbNE = texture2D(POST_TEXTURE, var_texcoord0.xy + (vec2(+1.0, -1.0) * tex_offset)).xyz;
    vec3 rgbSW = texture2D(POST_TEXTURE, var_texcoord0.xy + (vec2(-1.0, +1.0) * tex_offset)).xyz;
    vec3 rgbSE = texture2D(POST_TEXTURE, var_texcoord0.xy + (vec2(+1.0, +1.0) * tex_offset)).xyz;
    vec3 rgbM  = texture2D(POST_TEXTURE, var_texcoord0.xy).xyz;
	
    vec3 luma = vec3(0.299, 0.587, 0.114);
    float lumaNW = dot(rgbNW, luma);
    float lumaNE = dot(rgbNE, luma);
    float lumaSW = dot(rgbSW, luma);
    float lumaSE = dot(rgbSE, luma);
    float lumaM  = dot(rgbM, luma);
	
    float lumaMin = min(lumaM, min(min(lumaNW, lumaNE), min(lumaSW, lumaSE)));
    float lumaMax = max(lumaM, max(max(lumaNW, lumaNE), max(lumaSW, lumaSE)));
	
    vec2 dir;
    dir.x = -((lumaNW + lumaNE) - (lumaSW + lumaSE));
    dir.y =  ((lumaNW + lumaSW) - (lumaNE + lumaSE));
	
    float dirReduce = max((lumaNW + lumaNE + lumaSW + lumaSE) * (0.25 * FXAA_REDUCE_MUL), FXAA_REDUCE_MIN);
    
    float rcpDirMin = 1.0/(min(abs(dir.x), abs(dir.y)) + dirReduce);
	
    dir = min(vec2(FXAA_SPAN_MAX,  FXAA_SPAN_MAX),
              max(vec2(-FXAA_SPAN_MAX, -FXAA_SPAN_MAX), dir * rcpDirMin)) * tex_offset;
    
    vec3 rgbA = (1.0/2.0) * (
                             texture2D(POST_TEXTURE, var_texcoord0.xy + dir * (1.0/3.0 - 0.5)).xyz +
                             texture2D(POST_TEXTURE, var_texcoord0.xy + dir * (2.0/3.0 - 0.5)).xyz);
    vec3 rgbB = rgbA * (1.0/2.0) + (1.0/4.0) * (
                                                texture2D(POST_TEXTURE, var_texcoord0.xy + dir * (0.0/3.0 - 0.5)).xyz +
                                                texture2D(POST_TEXTURE, var_texcoord0.xy + dir * (3.0/3.0 - 0.5)).xyz);
    float lumaB = dot(rgbB, luma);

	vec4 color = vec4(1.0, 1.0, 1.0, 1.0);
    
    if((lumaB < lumaMin) || (lumaB > lumaMax)){
        color.xyz = rgbA;
    } else {
        color.xyz = rgbB;
    }
    color.a = 1.0;
	return color;
}

void main () {
	if (options.x == 1.0) {
		gl_FragColor = apply_fxaa();
	} else {
		gl_FragColor = texture2D(POST_TEXTURE, var_texcoord0);
		//gl_FragColor = vec4(0.4,0.4,0.4,1.0);
	}	

	//gl_FragColor = texture2D(POST_TEXTURE, var_texcoord0);

}