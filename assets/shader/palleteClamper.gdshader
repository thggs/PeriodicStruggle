shader_type canvas_item;

void fragment() {
		
	vec4 palette[256];  // Declare an array with 256 elements
	
	palette[0] = vec4(0.23, 0.13, 0.15, 1);
	palette[1] = vec4(0.49, 0.22, 0.20, 1);
	palette[2] = vec4(0.67, 0.32, 0.19, 1);
	palette[3] = vec4(0.81, 0.46, 0.17, 1);
	palette[4] = vec4(0.94, 0.71, 0.25, 1);
	
	palette[5] = vec4(1, 0.93, 0.51, 1);
	palette[6] = vec4(0.78, 0.83, 0.36, 1);
	palette[7] = vec4(0.39, 0.67, 0.25, 1);


    vec4 current_color = texture(TEXTURE, UV); // Get the current pixel color
    
    // Find the closest color in the palette
    vec4 closest_color = palette[0];
    float closest_distance = distance(current_color, palette[0]);
    
    for (int i = 1; i < 256; i++) {
        float distance_to_palette = distance(current_color, palette[i]);
        if (distance_to_palette < closest_distance) {
            closest_distance = distance_to_palette;
            closest_color = palette[i];
        }
    }
    
    COLOR = closest_color;
}

	