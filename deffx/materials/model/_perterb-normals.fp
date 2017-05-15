// todo
// needs nofrmal texture
// ref phong probably



varying mediump vec4 position;
varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 tint;


vec3 perturb(vec3 map, vec3 N, vec3 V, vec2 texcoord) {
  mat3 TBN = cotangent(N, -V, texcoord);
  return normalize(TBN * map);
}


void main()
{
	// Pre-multiply alpha since all runtime textures already are
	lowp vec4 tint_pm = vec4(tint.xyz * tint.w, tint.w);
	gl_FragColor = texture2D(DIFFUSE_TEXTURE, var_texcoord0.xy) * tint_pm;
}


varying vec3 vNormal;
varying vec2 vUv;
varying vec3 vViewPosition;

uniform sampler2D normalMap;
uniform vec2 uvRepeat;
const float normalScale = 0.85;

void main() {
  //extract normal map from your texture
  vec3 normalRGB = texture2D(normalMap, vUv * uvRepeat).rgb;
  vec3 normalMap = normalRGB * 2.0 - 1.0;
  //you can adjust its strength like so...
  normalMap.xy *= normalScale;

  vec3 N = normalize(vNormal);
  vec3 V = normalize(vViewPosition);
  vec3 normal = perturb(normalMap, N, V, vUv);

  gl_FragColor.rgb = normal;
  gl_FragColor.a = 1.0;
}