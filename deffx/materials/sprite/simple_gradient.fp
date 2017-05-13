varying highp vec2 var_texcoord0;

uniform highp sampler2D DIFFUSE_TEXTURE;
uniform highp vec4 resolution;


// if you need more colors in your gradients it's easy to add them
// when arrays are added to use then hopefully this will be able to be cleaner
uniform highp vec4 gradient_start;
uniform highp vec4 gradient_stop;

uniform highp vec4 color_1;
uniform highp vec4 color_2;


void main() {


    highp float  alpha = atan( -gradient_stop.y + gradient_start.y, gradient_stop.x - gradient_start.x );
    highp float  gradient_start_rotated_x = gradient_start.x*cos(alpha) - gradient_start.y*sin(alpha);
    highp float  gradient_stop_rotated_x   = gradient_stop.x*cos(alpha) - gradient_stop.y*sin(alpha);
    highp float  d = gradient_stop_rotated_x - gradient_start_rotated_x;
    

    //float y = resolution.y - gl_FragCoord.y;
	
    highp float x = var_texcoord0.x;
	highp float y = var_texcoord0.y;
    highp float x_location_rotated = x*cos( alpha ) - y*sin( alpha );
 
    gl_FragColor = mix(color_1, color_2, smoothstep( gradient_start_rotated_x + d, gradient_start_rotated_x + d, x_location_rotated ) );

 	//gl_FragColor = vec4(gradient_start_rotated_x,gradient_start_rotated_x,gradient_start_rotated_x, 1.0 );	
	//gl_FragColor = vec4(x_location_rotated,x_location_rotated,x_location_rotated, 1.0 );
    
}
