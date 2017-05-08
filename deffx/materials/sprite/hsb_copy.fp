varying mediump vec4 position;
varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 hsb;
// hsb.x = hue
// hsb.y = saturation
// hsb.z = brightness
// hsb.w =

// https://gamedev.stackexchange.com/questions/59797/glsl-shader-change-hue-saturation-brightness
vec3 rgb2hsb(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsb2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void main()
{
	// Pre-multiply alpha since all runtime textures already are
    vec4 textureColor = texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy);
    vec3 fragRGB = textureColor.rgb;
    vec3 fragHSB = rgb2hsb(fragRGB).xyz;
    fragHSB.x += hsb.x;
    fragHSB.yz *= hsb.yz;
    fragHSB.xyz = mod(fragHSB.xyz, 1.0);
    fragRGB = hsb2rgb(fragHSB);
    gl_FragColor = vec4(fragRGB, textureColor.w);
}
