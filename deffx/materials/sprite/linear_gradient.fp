varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 resolution;


// if you need more colors in your gradients it's easy to add them
// when arrays are added to use then hopefully this will be able to be cleaner
uniform lowp vec4 gradient_start;
uniform lowp vec4 gradient_stop;

uniform lowp vec4 number_of_colors;
uniform lowp vec4 color_1;
uniform lowp vec4 color_2;
uniform lowp vec4 color_3;
uniform lowp vec4 color_4;
uniform lowp vec4 color_5;
uniform lowp vec4 color_6;
uniform lowp vec4 color_7;
uniform lowp vec4 color_8;

uniform lowp vec4 number_of_stops;
uniform lowp vec4 stop_1;
uniform lowp vec4 stop_2;
uniform lowp vec4 stop_3;
uniform lowp vec4 stop_4;
uniform lowp vec4 stop_5;
uniform lowp vec4 stop_6;
uniform lowp vec4 stop_7;
uniform lowp vec4 stop_8;


void main() {

	vec4 colors[];
	float stops[];
	
	// replace when can use arrays
	
	if (number_of_colors.x > 0.0) colors[1] = color_1;
	if (number_of_colors.x > 1.0) colors[2] = color_2; 
	if (number_of_colors.x > 2.0) colors[3] = color_3;
	if (number_of_colors.x > 3.0) colors[4] = color_4;
	if (number_of_colors.x > 4.0) colors[5] = color_5;
	if (number_of_colors.x > 5.0) colors[6] = color_6;
	if (number_of_colors.x > 6.0) colors[7] = color_7;
	if (number_of_colors.x > 7.0) colors[8] = color_8;

	if (number_of_stops.x > 0.0) stops[1] = stop_1.x;
	if (number_of_stops.x > 1.0) stops[2] = stop_2.x; 
	if (number_of_stops.x > 2.0) stops[3] = stop_3.x;
	if (number_of_stops.x > 3.0) stops[4] = stop_4.x;
	if (number_of_stops.x > 4.0) stops[5] = stop_5.x;
	if (number_of_stops.x > 5.0) stops[6] = stop_6.x;
	if (number_of_stops.x > 6.0) stops[7] = stop_7.x;
	if (number_of_stops.x > 7.0) stops[8] = stop_8.x;
	
    
    float  alpha = atan( -gradient_stop.y + gradient_start.y, gradient_stop.x - gradient_start.x );
    float  gradient_start_rotated_x = gradient_start.x*cos(alpha) - gradient_start.y*sin(alpha);
    float  gradient_stop_rotated_x   = gradient_stop.x*cos(alpha) - gradient_stop.y*sin(alpha);
    float  d = gradient_stop_rotated_x - gradient_start_rotated_x;
    

    //float y = resolution.y - gl_FragCoord.y;
	float y = var_texcoord0.y;
    float x = var_texcoord0.x;
    float x_location_rotated = x*cos( alpha ) - y*sin( alpha );
 
	vec4 color;

    color = mix(colors[0], colors[1], smoothstep( gradient_start_rotated_x + stops[0]*d, gradient_start_rotated_x + stops[1]*d, x_location_rotated ) );
    for ( int i=1; i<number_of_stops.x-1; ++i ) {
        color = mix(gl_FragColor, colors[i], smoothstep( gradient_start_rotated_x + stops[i]*d, gradient_start_rotated_x + stops[i+1]*d, x_location_rotated ) );
    }

	gl_FragColor = color;
	//gl_FragColor = vec4(var_texcoord0.x, var_texcoord0.x, var_texcoord0.x, sin(var_texcoord0.y));
 
    
}
