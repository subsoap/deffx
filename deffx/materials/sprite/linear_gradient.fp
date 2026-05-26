varying mediump vec2 var_texcoord0;

uniform lowp sampler2D DIFFUSE_TEXTURE;
uniform lowp vec4 resolution;


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
    float  alpha = atan( -gradient_stop.y + gradient_start.y, gradient_stop.x - gradient_start.x );
    float  gradient_start_rotated_x = gradient_start.x*cos(alpha) - gradient_start.y*sin(alpha);
    float  gradient_stop_rotated_x   = gradient_stop.x*cos(alpha) - gradient_stop.y*sin(alpha);
    float  d = gradient_stop_rotated_x - gradient_start_rotated_x;
    //float y = resolution.y - gl_FragCoord.y;
    float y = var_texcoord0.y;
    float x = var_texcoord0.x;
    float x_location_rotated = x*cos( alpha ) - y*sin( alpha );

    vec4 color = mix(color_1, color_2, smoothstep( gradient_start_rotated_x + stop_1.x*d, gradient_start_rotated_x + stop_2.x*d, x_location_rotated ) );
    if (number_of_colors.x > 2.0 && number_of_stops.x > 2.0) {
        color = mix(color, color_3, smoothstep( gradient_start_rotated_x + stop_2.x*d, gradient_start_rotated_x + stop_3.x*d, x_location_rotated ) );
    }
    if (number_of_colors.x > 3.0 && number_of_stops.x > 3.0) {
        color = mix(color, color_4, smoothstep( gradient_start_rotated_x + stop_3.x*d, gradient_start_rotated_x + stop_4.x*d, x_location_rotated ) );
    }
    if (number_of_colors.x > 4.0 && number_of_stops.x > 4.0) {
        color = mix(color, color_5, smoothstep( gradient_start_rotated_x + stop_4.x*d, gradient_start_rotated_x + stop_5.x*d, x_location_rotated ) );
    }
    if (number_of_colors.x > 5.0 && number_of_stops.x > 5.0) {
        color = mix(color, color_6, smoothstep( gradient_start_rotated_x + stop_5.x*d, gradient_start_rotated_x + stop_6.x*d, x_location_rotated ) );
    }
    if (number_of_colors.x > 6.0 && number_of_stops.x > 6.0) {
        color = mix(color, color_7, smoothstep( gradient_start_rotated_x + stop_6.x*d, gradient_start_rotated_x + stop_7.x*d, x_location_rotated ) );
    }
    if (number_of_colors.x > 7.0 && number_of_stops.x > 7.0) {
        color = mix(color, color_8, smoothstep( gradient_start_rotated_x + stop_7.x*d, gradient_start_rotated_x + stop_8.x*d, x_location_rotated ) );
    }

    gl_FragColor = color;
    //gl_FragColor = vec4(var_texcoord0.x, var_texcoord0.x, var_texcoord0.x, sin(var_texcoord0.y));
}
