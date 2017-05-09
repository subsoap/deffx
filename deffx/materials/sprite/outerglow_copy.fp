varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 tint;

uniform lowp vec4 rgba;
uniform lowp vec4 options;
// options : x pixel width, y pixel height, z outline only, w width

void main()
{
	
    vec4 colorTexture = texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy);
	
	float dx = options.x*options.w;
	float dy = options.y*options.w;
    float diag = 0.7071;
	
    float a0 = texture2D(DIFFUSE_TEXTURE, var_texcoord0 + vec2(-dx*diag, dy*diag)).a;
    float a1 = texture2D(DIFFUSE_TEXTURE, var_texcoord0 + vec2(dx*diag, -dy*diag)).a;
    float a2 = texture2D(DIFFUSE_TEXTURE, var_texcoord0 + vec2(-dx*diag, -dy*diag)).a;
    float a3 = texture2D(DIFFUSE_TEXTURE, var_texcoord0 + vec2(dx*diag, dy*diag)).a;
    float a4 = texture2D(DIFFUSE_TEXTURE, var_texcoord0 + vec2(-dx, 0.0)).a;
    float a5 = texture2D(DIFFUSE_TEXTURE, var_texcoord0 + vec2(dx, 0.0)).a;
    float a6 = texture2D(DIFFUSE_TEXTURE, var_texcoord0 + vec2(0.0, dy)).a;
    float a7 = texture2D(DIFFUSE_TEXTURE, var_texcoord0 + vec2(0.0, -dy)).a;
	
    float ina=max(max(max(max(max(max(max(a0,a1),a2),a3),a4),a5),a6),a7)-colorTexture.a;
    if(options.z==0)
    {
        float outa = ina + colorTexture.a*(1.0-ina);
        vec3 outrgb = (vec3(rgba.x/255.0, rgba.y/255.0, rgba.z/255.0)*ina + colorTexture.rgb*colorTexture.a*(1.0-ina));
        gl_FragColor = vec4(outrgb, outa);
    }
    else
    {
        gl_FragColor = vec4(vec3(rgba.x/255.0, rgba.y/255.0, rgba.z/255.0)*ina, ina);
    }
}
