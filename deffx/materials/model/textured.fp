varying mediump vec2 var_texcoord0;

uniform sampler2D diffuse_texture;
uniform lowp vec4 tint;
uniform lowp vec4 timer;

void main()
{
    lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w * timer.x);
    gl_FragColor = texture2D(diffuse_texture, var_texcoord0) * tint_pm;
}