varying mediump vec2 var_texcoord0;
varying mediump vec3 var_position;
varying mediump vec3 var_normal;

uniform lowp vec4 eye;
uniform lowp vec4 lightPos4;
uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp sampler2D NORMAL_MAP;
//uniform lowp sampler2D PASS_TEXTURE;

//const vec3 lightPos = vec3(1.0,1.0,1.0);
const vec3 diffuseColor = vec3(0.5, 0.5, 0.5);
const vec3 specColor = vec3(0.7, 0.7, 0.7);

mat3 cotangent(vec3 N, vec3 p, vec2 uv) {
  // get edge vectors of the pixel triangle
  vec3 dp1 = dFdx(p);
  vec3 dp2 = dFdy(p);
  vec2 duv1 = dFdx(uv);
  vec2 duv2 = dFdy(uv);

  // solve the linear system
  vec3 dp2perp = cross(dp2, N);
  vec3 dp1perp = cross(N, dp1);
  vec3 T = dp2perp * duv1.x + dp1perp * duv2.x;
  vec3 B = dp2perp * duv1.y + dp1perp * duv2.y;

  // construct a scale-invariant frame 
  float invmax = 1.0 / sqrt(max(dot(T,T), dot(B,B)));
  return mat3(T * invmax, B * invmax, N);
}

vec3 perturb(vec3 map, vec3 N, vec3 V, vec2 texcoord) {
  mat3 TBN = cotangent(N, -V, texcoord);
  return normalize(TBN * map);
}




void main() {

	vec2 uv_repeat = vec2(5.0, 1.0);
	float normal_weight = 0.85;
	vec3 view_position = normalize(vec3(0.0, 0.0, 1.0));

	vec3 normal_map_rgb = texture2D(NORMAL_MAP, var_texcoord0 * uv_repeat).rgb;
	vec3 normal_map = normal_map_rgb * 2.0 - 1.0;
	normal_map.xy = normal_map.xy * normal_weight;
	
	vec3 lightPos = vec3(lightPos4.x, lightPos4.y, lightPos4.z);
	vec3 lightDir = normalize(lightPos - var_position);
	vec3 perturb_normal = perturb(normal_map, normalize(var_normal), view_position, var_texcoord0);

	// this is not working yet

	vec3 normal = normalize(normal_map) * 0.25 + normalize(var_normal) * 0.75;
	
	
	float lambertian = max(dot(lightDir, normal), 0.0);
	float specular = 0.0;
	
	if(lambertian > 0.0) {
	    vec3 viewDir = normalize(-var_position);
	    vec3 halfDir = normalize(lightDir + viewDir);
	    float specAngle = max(dot(halfDir, normal), 0.0);
		specular = pow(specAngle, 32.0);
	}

	gl_FragColor = vec4(lambertian * texture2D(DIFFUSE_TEXTURE, var_texcoord0) + specular * specColor, 1.0);

}