varying mediump vec2 var_texcoord0;
varying mediump vec3 var_position;
varying mediump vec3 var_normal;

uniform lowp vec4 eye;
uniform lowp vec4 lightPos4;
uniform lowp sampler2D DIFFUSE_TEXTURE;

// todo: update near far values from render script camera
float near = 0.1; 
float far  = 100.0; 

float linearize_depth(float depth) 
{
    float z = depth * 2.0 - 1.0; // Back to NDC 
    return (2.0 * near * far) / (far + near - z * (far - near));	
}


void main( void )
{
	float depth = linearize_depth(gl_FragCoord.z) / far;

    gl_FragColor = vec4(vec3(depth), 1.0f);
}