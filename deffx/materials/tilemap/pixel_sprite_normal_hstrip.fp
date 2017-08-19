varying mediump vec2 var_texcoord0;
varying mediump vec3 var_normal;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 tint;
uniform lowp vec4 light_color_1;
uniform lowp vec4 light_direction_1;

void main()
{
    // Pre-multiply alpha since all runtime textures already are
    lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
	lowp vec2 normal_offset = vec2(0.0, 0.5);

	vec4 diffuse = texture2D(DIFFUSE_TEXTURE, var_texcoord0) * tint_pm;

	vec3 normal;
	normal.xy = texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy + normal_offset).rg * 2.0 - 1.0;
	normal.z = sqrt(1.0 - dot(normal.xy, normal.xy));
	

	vec3 ambient = vec3(0.3);
	vec4 light_color_2 = vec4(0.7,0.7,0.8, 2.0);
	vec4 light_direction_2 = vec4(-1.0, 0.0, 0.0, 0.0);
	vec3 light = ambient.rgb + light_color_2.rgb * max(-dot(var_normal, light_direction_2.xyz), 0.0) * light_color_2.a + light_color_1.rgb * max(-dot(var_normal, light_direction_1.xyz), 0.0);
	light = clamp(light, 0.0, 1.0);


	
    gl_FragColor = vec4(diffuse.rgb * light.rgb, diffuse.a);
}
