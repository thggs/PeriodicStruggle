shader_type canvas_item;

uniform int pixel_x : hint_range(1, 50) = int(50);
uniform int pixel_y : hint_range(1, 50) = int(50);


void fragment() {
    vec2 uv = UV;
    vec2 pixel_size = vec2(float(pixel_x), float(pixel_y));
	
    // Calculate the position in the grid
    uv /= pixel_size;
    uv = floor(uv);
    uv *= pixel_size;

    // Sample the original texture
    COLOR = texture(TEXTURE, uv);
}
