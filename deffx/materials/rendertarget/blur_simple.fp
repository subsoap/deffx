
varying mediump vec2 var_texcoord0;
uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 options;
// options.x = samplesx, options.y = samplesy - both must be odd
// options.z = 
uniform lowp vec4 delta;
uniform lowp vec4 resolution;


void main()
{
    vec3 irgb = texture2D(DIFFUSE_TEXTURE, var_texcoord0).rgb;
    float ResS = resolution.x;
    float ResT = resolution.y;

    vec2 stp0 = vec2(1./ResS, 0.);
    vec2 st0p = vec2(0., 1./ResT);
    vec2 stpp = vec2(1./ResS, 1./ResT);
    vec2 stpm = vec2(1./ResS, -1./ResT);

    vec3 i00 = texture2D(DIFFUSE_TEXTURE, var_texcoord0).rgb;
    vec3 im1m1 = texture2D(DIFFUSE_TEXTURE, var_texcoord0-stpp*delta.x).rgb;
    vec3 ip1p1 = texture2D(DIFFUSE_TEXTURE, var_texcoord0+stpp*delta.x).rgb;
    vec3 im1p1 = texture2D(DIFFUSE_TEXTURE, var_texcoord0-stpm*delta.x).rgb;
    vec3 ip1m1 = texture2D(DIFFUSE_TEXTURE, var_texcoord0+stpm*delta.x).rgb;
    vec3 im10 = texture2D(DIFFUSE_TEXTURE, var_texcoord0-stp0*delta.x).rgb;
    vec3 ip10 = texture2D(DIFFUSE_TEXTURE, var_texcoord0+stp0*delta.x).rgb;
    vec3 i0m1 = texture2D(DIFFUSE_TEXTURE, var_texcoord0-st0p*delta.x).rgb;
    vec3 i0p1 = texture2D(DIFFUSE_TEXTURE, var_texcoord0+st0p*delta.x).rgb;

    vec3 target = vec3(0., 0., 0.);
    target += 1.*(im1m1+ip1m1+ip1p1+im1p1); 
    target += 2.*(im10+ip10+i0p1);
    target += 4.*(i00);
    target /= 16.;
    gl_FragColor = vec4(target, 1.);
}