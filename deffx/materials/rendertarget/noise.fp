varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 options;
// options.x = seed, options.y = noise strength


float rand(vec2 co)
{
    return fract(sin(dot(co.xy, vec2(12.9898, 78.2333))) * 43758.54532);
	// this noise method doesn't look great when very visible or static
	// use a better rng method for better noise
	// https://gist.github.com/patriciogonzalezvivo/670c22f3966e662d2f83
}

void main()
{
    vec4 color = texture2D(DIFFUSE_TEXTURE, var_texcoord0);
    float randomValue = rand(gl_FragCoord.xy * options.x);
    float diff = (randomValue - 0.5) * options.y;


    color.r += diff;
    color.g += diff;
    color.b += diff;


    gl_FragColor = color;

}
