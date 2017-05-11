varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 options;
// options.x = seed, options.y = noise strength

// https://gist.github.com/patriciogonzalezvivo/670c22f3966e662d2f83

float random(vec2 co)
{
    return fract(sin(dot(co.xy, vec2(12.9898, 78.2333))) * 43758.54532);


}

// 2D Noise based on Morgan McGuire @morgan3d
// https://www.shadertoy.com/view/4dS3Wd
float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners porcentages
    return mix(a, b, u.x) + 
            (c - a)* u.y * (1.0 - u.x) + 
            (d - b) * u.x * u.y;
}

void main()
{
    vec4 color = texture2D(DIFFUSE_TEXTURE, var_texcoord0);
    float randomValue = noise(random(gl_FragCoord.xy * options.x));
    float diff = (randomValue - 0.5) * options.y;


    color.r += diff;
    color.g += diff;
    color.b += diff;


    gl_FragColor = color;

}
