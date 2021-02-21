shader_type canvas_item;

uniform vec3 aggression_color = vec3(1.0,1.0,1.0);

void fragment() {
	COLOR = texture(TEXTURE, UV) * vec4(aggression_color,1.0);
}