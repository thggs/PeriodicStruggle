shader_type canvas_item;

uniform float amount : hint_range(0, 1); // Ensure amount is clamped between 0 and 1
uniform vec3 color;

void fragment() 
{
    vec3 new_color = mix(COLOR.rgb, color, amount);
    COLOR.rgb = new_color;
}
