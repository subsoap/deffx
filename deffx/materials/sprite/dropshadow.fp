varying mediump vec4 position;
varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 hsb;
// hsb.x = hue
// hsb.y = saturation
// hsb.z = brightness
// hsb.w = unused

// https://gamedev.stackexchange.com/questions/59797/glsl-shader-change-hue-saturation-brightness
// https://www.shadertoy.com/view/ltBSWd
// https://www.shadertoy.com/view/ldyXWz

vec3 RGBtoHSB(vec3 rgb)
{
    // Hue: red = 0/6, yellow = 1/6, green = 2/6,
    //      cyan = 3/6, blue = 4/6, magenta = 5/6
    vec3 hsb;
    float cmax = max(rgb.r, max(rgb.g, rgb.b));
    float cmin = min(rgb.r, min(rgb.g, rgb.b));
    
    hsb.z = cmax; // value

    float chroma = cmax - cmin;
    //if(chroma != 0.0)
    {
        hsb.y = chroma / cmax; // saturation

        //if(cmax == rgb.r)
        if(rgb.r > rgb.g && rgb.r > rgb.b)
        {
            hsb.x = (0.0 + (rgb.g - rgb.b) / chroma) / 6.0; // hue
        }
        //else if(cmax == rgb.m_Green)
        else if(rgb.g > rgb.b)
        {
            hsb.x = (2.0 + (rgb.b - rgb.r) / chroma) / 6.0; // hue
        }
        else
        {
            hsb.x = (4.0 + (rgb.r - rgb.g) / chroma) / 6.0; // hue
        }

        // Make sure hue is in range [0..1]
        hsb.x = fract(hsb.x);
    }
    return hsb;
}

vec3 HSBtoRGB(in vec3 c) // thanks to iq for this much more compact version!
{
    vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0, 0.0, 1.0);
    return c.z * mix(vec3(1.0), rgb, c.y);
}


void main()
{
    vec4 textureColor = texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy);
    vec3 fragRGB = textureColor.rgb;
    vec3 fragHSB = RGBtoHSB(fragRGB).xyz;
    fragHSB.x += hsb.x;
    fragHSB.yz *= hsb.yz;
   // fragHSB.xyz = mod(fragHSB.xyz, 1.0);
    fragRGB = HSBtoRGB(fragHSB);
    gl_FragColor = vec4(fragRGB, textureColor.a);
}