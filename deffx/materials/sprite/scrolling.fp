varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 tint;
uniform lowp vec4 offset;
uniform lowp vec4 timer;

void main()
{
    vec2 q = var_texcoord0.xy * 5; // should account for w/h scale
    vec2 uv = 0.5 + (q-0.5)*(0.9 + 0.1*sin(2.5*timer.x));	

    lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
    gl_FragColor = texture2D(DIFFUSE_TEXTURE, vec2(uv.x,-uv.y) + offset.xy) * tint_pm;
}
